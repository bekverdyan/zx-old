module Exchange exposing (Exchange, Msg(..), preset, update)

import Bootstrap.Button as Button
import Bootstrap.ButtonGroup as ButtonGroup
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.Table as Table
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



--MODEL


type alias Model =
    { exchange : Exchange
    , switches : Switches
    }


type alias Switches =
    { hopper : Switch
    , hopperMode : Switch
    , billValidator : Switch
    , rfidReader1 : Switch
    , rfidReader2 : Switch
    , dispenser : Switch
    , cardOut : Switch
    , network : Switch
    }


type alias Exchange =
    { counters : Counters
    , settings : Settings
    }


type alias Counters =
    { billCach : ( Int, Int )
    , coinCach : ( Int, Int )
    , cardRechargeCach : ( Int, Int )
    , soldCardCach : ( Int, Int )
    , cardDispense : ( Int, Int )
    , faultyCard : ( Int, Int )
    , coinHopperCoin : ( Int, Int )
    , coinHopperValue : ( Int, Int )
    , bonusCache : ( Int, Int )
    }


type alias Settings =
    { coinNominal : Int
    , hopper : Faze
    , hopperCoinNominal : Int
    , hopperMode : Faze
    , billValidator : Faze
    , billNominal : List Int
    , rfidReader1 : Faze
    , rfidReader2 : Faze
    , dispenser : Faze
    , cardOut : Faze
    , cardPrice : Int
    , network : Faze
    , deviceId : String
    , serverCode : String
    , bonusPercent : Int
    , bonusThreshold : Int
    }



-- HELPERS


preset : Exchange
preset =
    { counters = countersPreset
    , settings = settingsPreset
    }


countersPreset : Counters
countersPreset =
    { billCach = ( 0, 0 )
    , coinCach = ( 0, 0 )
    , cardRechargeCach = ( 0, 0 )
    , soldCardCach = ( 0, 0 )
    , cardDispense = ( 0, 0 )
    , faultyCard = ( 0, 0 )
    , coinHopperCoin = ( 0, 0 )
    , coinHopperValue = ( 0, 0 )
    , bonusCache = ( 0, 0 )
    }


settingsPreset : Settings
settingsPreset =
    { coinNominal = 0
    , hopper = Disabled
    , hopperCoinNominal = 0
    , hopperMode = Mode_1
    , billValidator = Disabled
    , billNominal = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
    , rfidReader1 = Disabled
    , rfidReader2 = Disabled
    , dispenser = Disabled
    , cardOut = ToGate
    , cardPrice = 0
    , network = None
    , deviceId = ""
    , serverCode = ""
    , bonusPercent = 0
    , bonusThreshold = 0
    }



--UPDATE


type Msg
    = ExchangeRadioMsg Switch
    | ExchangeInputsMsg Variable


type Switch
    = Hopper Faze
    | HopperMode Faze
    | BillValidator Faze
    | RfidReader1 Faze
    | RfidReader2 Faze
    | Dispenser Faze
    | CardOut Faze
    | Network Faze


type Variable
    = CoinNominal Int
    | HopperCoinNominal Int
    | BillNominal (List Int)
    | DeviceId String
    | ServerCode String
    | BonusPercent Int
    | BonusThreshold Int
    | CardPrice Int


type Faze
    = Enabled
    | Disabled
    | CcTalk
    | Pulse
    | Mode_1
    | Mode_2
    | CRT_531
    | TCD_820M
    | ToGate
    | FullOut
    | None
    | RS_485
    | Can
    | Ethernet
    | WiFi


update : Msg -> Model -> ( Model, Maybe Msg )
update msg model =
    let
        settings =
            model.exchange.settings
    in
    case msg of
        ExchangeRadioMsg switch ->
            let
                switches =
                    model.switches
            in
            case switch of
                Hopper faze ->
                    let
                        switchedModel =
                            { model | switches = { switches | hopper = Hopper faze } }
                    in
                    ( changeSettings { settings | hopper = faze } switchedModel, Nothing )

                HopperMode faze ->
                    let
                        switchedModel =
                            { model | switches = { switches | hopperMode = HopperMode faze } }
                    in
                    ( changeSettings { settings | hopperMode = faze } switchedModel, Nothing )

                BillValidator faze ->
                    let
                        switchedModel =
                            { model | switches = { switches | billValidator = BillValidator faze } }
                    in
                    ( changeSettings { settings | billValidator = faze } switchedModel, Nothing )

                RfidReader1 faze ->
                    let
                        switchedModel =
                            { model | switches = { switches | rfidReader1 = RfidReader1 faze } }
                    in
                    ( changeSettings { settings | rfidReader1 = faze } switchedModel, Nothing )

                RfidReader2 faze ->
                    let
                        switchedModel =
                            { model | switches = { switches | rfidReader2 = RfidReader2 faze } }
                    in
                    ( changeSettings { settings | rfidReader2 = faze } switchedModel, Nothing )

                Dispenser faze ->
                    let
                        switchedModel =
                            { model | switches = { switches | dispenser = Dispenser faze } }
                    in
                    ( changeSettings { settings | dispenser = faze } switchedModel, Nothing )

                CardOut faze ->
                    let
                        switchedModel =
                            { model | switches = { switches | cardOut = CardOut faze } }
                    in
                    ( changeSettings { settings | cardOut = faze } switchedModel, Nothing )

                Network faze ->
                    let
                        switchedModel =
                            { model | switches = { switches | network = Network faze } }
                    in
                    ( changeSettings { settings | network = faze } switchedModel, Nothing )

        ExchangeInputsMsg variable ->
            case variable of
                CoinNominal nominal ->
                    ( changeSettings { settings | coinNominal = nominal } model, Nothing )

                HopperCoinNominal nominal ->
                    ( changeSettings { settings | hopperCoinNominal = nominal } model, Nothing )

                BillNominal nominal ->
                    ( changeSettings { settings | billNominal = nominal } model, Nothing )

                DeviceId id ->
                    ( changeSettings { settings | deviceId = id } model, Nothing )

                ServerCode code ->
                    ( changeSettings { settings | serverCode = code } model, Nothing )

                BonusPercent percent ->
                    ( changeSettings { settings | bonusPercent = percent } model, Nothing )

                BonusThreshold threshold ->
                    ( changeSettings { settings | bonusThreshold = threshold } model, Nothing )

                CardPrice price ->
                    ( changeSettings { settings | cardPrice = price } model, Nothing )


changeSettings : Settings -> Model -> Model
changeSettings settings model =
    let
        exchange =
            model.exchange
    in
    { model | exchange = { exchange | settings = settings } }



-- VIEW


viewCounters : Counters -> Html Msg
viewCounters counters =
    Table.table
        { options = [ Table.striped, Table.hover ]
        , thead = Table.thead [] []
        , tbody =
            Table.tbody []
                [ viewCounter counters.billCach "Bill Cach"
                , viewCounter counters.coinCach "Coin Cach"
                , viewCounter counters.cardRechargeCach "Card Rechange Cach"
                , viewCounter counters.soldCardCach "Sold Card Cach"
                , viewCounter counters.cardDispense "Card Dispense"
                , viewCounter counters.faultyCard "Faulty Card"
                , viewCounter counters.coinHopperCoin "Coin HopperCoin"
                , viewCounter counters.coinHopperValue "Coin Hopper Value"
                , viewCounter counters.bonusCache "Bonus Cache"
                ]
        }


viewCounter : ( Int, Int ) -> String -> Table.Row Msg
viewCounter pointers name =
    Table.tr []
        [ Table.td [] [ text name ]
        , Table.td []
            [ text <|
                String.fromInt <|
                    Tuple.first pointers
            ]
        , Table.td []
            [ text <|
                String.fromInt <|
                    Tuple.second pointers
            ]
        ]


viewSettings : Settings -> Model -> Html Msg
viewSettings settings model =
    Table.table
        { options = []
        , thead = Table.thead [] []
        , tbody =
            Table.tbody []
                [ viewCoinNominal settings
                , viewHopper settings model.switches
                , viewHopperCoinNominal settings
                , viewHopperMode settings model.switches
                , viewBillValidator settings model.switches
                , viewBillNominal settings
                , viewRfidReader1 settings model.switches
                , viewRfidReader2 settings model.switches
                , viewDispenser settings model.switches
                , viewCardOut settings model.switches
                , viewCardPrice settings
                , viewNetwork settings model.switches
                , viewDeviceId settings
                , viewServerCode settings
                , viewBonusPercent settings
                , viewBonusThreshold settings
                ]
        }


viewCoinNominal : Settings -> Table.Row Msg
viewCoinNominal settings =
    Table.tr []
        [ Table.td []
            [ text "Coin Nominal" ]
        , Table.td []
            [ InputGroup.config
                (InputGroup.number
                    [ Input.placeholder "Integer"
                    , Input.value <|
                        String.fromInt settings.coinNominal
                    ]
                )
                |> InputGroup.successors
                    [ InputGroup.button
                        [ Button.secondary
                        , Button.onClick <|
                            ExchangeInputsMsg <|
                                CoinNominal settings.coinNominal
                        ]
                        [ text "Save" ]
                    ]
                |> InputGroup.view
            ]
        ]


viewHopperCoinNominal : Settings -> Table.Row Msg
viewHopperCoinNominal settings =
    Table.tr []
        [ Table.td []
            [ text "Hopper Coin Nominal" ]
        , Table.td []
            [ InputGroup.config
                (InputGroup.number
                    [ Input.placeholder "Integer"
                    , Input.value <|
                        String.fromInt settings.hopperCoinNominal
                    ]
                )
                |> InputGroup.successors
                    [ InputGroup.button
                        [ Button.secondary
                        , Button.onClick <|
                            ExchangeInputsMsg <|
                                HopperCoinNominal settings.coinNominal
                        ]
                        [ text "Save" ]
                    ]
                |> InputGroup.view
            ]
        ]


viewBillNominal : Settings -> Table.Row Msg
viewBillNominal settings =
    Table.tr []
        [ Table.td []
            [ text "Bill Nominal" ]
        , Table.td []
            [ text "gago" ]
        ]


viewDeviceId : Settings -> Table.Row Msg
viewDeviceId settings =
    Table.tr []
        [ Table.td []
            [ text "Device ID" ]
        , Table.td []
            [ InputGroup.config
                (InputGroup.text
                    [ Input.placeholder "String"
                    , Input.value <|
                        settings.deviceId
                    ]
                )
                |> InputGroup.successors
                    [ InputGroup.button
                        [ Button.secondary
                        , Button.onClick <|
                            ExchangeInputsMsg <|
                                DeviceId settings.deviceId
                        ]
                        [ text "Save" ]
                    ]
                |> InputGroup.view
            ]
        ]


viewCardPrice : Settings -> Table.Row Msg
viewCardPrice settings =
    Table.tr []
        [ Table.td []
            [ text "Card Price" ]
        , Table.td []
            [ InputGroup.config
                (InputGroup.number
                    [ Input.placeholder "Integer"
                    , Input.value <|
                        String.fromInt <|
                            settings.cardPrice
                    ]
                )
                |> InputGroup.successors
                    [ InputGroup.button
                        [ Button.secondary
                        , Button.onClick <|
                            ExchangeInputsMsg <|
                                CardPrice settings.cardPrice
                        ]
                        [ text "Save" ]
                    ]
                |> InputGroup.view
            ]
        ]


viewServerCode : Settings -> Table.Row Msg
viewServerCode settings =
    Table.tr []
        [ Table.td []
            [ text "Server Code" ]
        , Table.td []
            [ InputGroup.config
                (InputGroup.text
                    [ Input.placeholder "String"
                    , Input.value <|
                        settings.serverCode
                    ]
                )
                |> InputGroup.successors
                    [ InputGroup.button
                        [ Button.secondary
                        , Button.onClick <|
                            ExchangeInputsMsg <|
                                ServerCode settings.serverCode
                        ]
                        [ text "Save" ]
                    ]
                |> InputGroup.view
            ]
        ]


viewBonusPercent : Settings -> Table.Row Msg
viewBonusPercent settings =
    Table.tr []
        [ Table.td []
            [ text "Bonus Percent" ]
        , Table.td []
            [ InputGroup.config
                (InputGroup.number
                    [ Input.placeholder "Integer"
                    , Input.value <|
                        String.fromInt settings.bonusPercent
                    ]
                )
                |> InputGroup.successors
                    [ InputGroup.button
                        [ Button.secondary
                        , Button.onClick <|
                            ExchangeInputsMsg <|
                                BonusPercent settings.bonusPercent
                        ]
                        [ text "Save" ]
                    ]
                |> InputGroup.view
            ]
        ]


viewBonusThreshold : Settings -> Table.Row Msg
viewBonusThreshold settings =
    Table.tr []
        [ Table.td []
            [ text "Bonus Threshold" ]
        , Table.td []
            [ InputGroup.config
                (InputGroup.number
                    [ Input.placeholder "Number"
                    , Input.value <|
                        String.fromInt settings.bonusThreshold
                    ]
                )
                |> InputGroup.successors
                    [ InputGroup.button
                        [ Button.secondary
                        , Button.onClick <|
                            ExchangeInputsMsg <|
                                BonusThreshold settings.bonusThreshold
                        ]
                        [ text "Save" ]
                    ]
                |> InputGroup.view
            ]
        ]


viewHopper : Settings -> Switches -> Table.Row Msg
viewHopper settings switches =
    Table.tr []
        [ Table.td []
            [ text "Hopper" ]
        , Table.td []
            [ ButtonGroup.radioButtonGroup []
                [ ButtonGroup.radioButton
                    (switches.hopper == Hopper Disabled)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            Hopper Disabled
                    ]
                    [ text "Disabled" ]
                , ButtonGroup.radioButton
                    (switches.hopper == Hopper CcTalk)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            Hopper CcTalk
                    ]
                    [ text "CcTalk" ]
                , ButtonGroup.radioButton
                    (switches.hopper == Hopper Pulse)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            Hopper Pulse
                    ]
                    [ text "Pulse" ]
                ]
            ]
        ]


viewHopperMode : Settings -> Switches -> Table.Row Msg
viewHopperMode settings switches =
    Table.tr []
        [ Table.td []
            [ text "Hopper Mode" ]
        , Table.td []
            [ ButtonGroup.radioButtonGroup []
                [ ButtonGroup.radioButton
                    (switches.hopperMode == HopperMode Mode_1)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            HopperMode Mode_1
                    ]
                    [ text "Mode 1" ]
                , ButtonGroup.radioButton
                    (switches.hopperMode == HopperMode Mode_2)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            HopperMode Mode_2
                    ]
                    [ text "Mode 2" ]
                ]
            ]
        ]


viewBillValidator : Settings -> Switches -> Table.Row Msg
viewBillValidator settings switches =
    Table.tr []
        [ Table.td []
            [ text "Bill Validator" ]
        , Table.td []
            [ ButtonGroup.radioButtonGroup []
                [ ButtonGroup.radioButton
                    (switches.billValidator == BillValidator Disabled)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            BillValidator Disabled
                    ]
                    [ text "Disabled" ]
                , ButtonGroup.radioButton
                    (switches.billValidator == BillValidator CcTalk)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            BillValidator CcTalk
                    ]
                    [ text "CcTalk" ]
                ]
            ]
        ]


viewRfidReader1 : Settings -> Switches -> Table.Row Msg
viewRfidReader1 settings switches =
    Table.tr []
        [ Table.td []
            [ text "RFID Reader 1" ]
        , Table.td []
            [ ButtonGroup.radioButtonGroup []
                [ ButtonGroup.radioButton
                    (switches.rfidReader1 == RfidReader1 Disabled)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            RfidReader1 Disabled
                    ]
                    [ text "Disabled" ]
                , ButtonGroup.radioButton
                    (switches.rfidReader1 == RfidReader1 Enabled)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            RfidReader1 Enabled
                    ]
                    [ text "Enabled" ]
                ]
            ]
        ]


viewRfidReader2 : Settings -> Switches -> Table.Row Msg
viewRfidReader2 settings switches =
    Table.tr []
        [ Table.td []
            [ text "RFID Reader 2" ]
        , Table.td []
            [ ButtonGroup.radioButtonGroup []
                [ ButtonGroup.radioButton
                    (switches.rfidReader2 == RfidReader2 Disabled)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            RfidReader2 Disabled
                    ]
                    [ text "Disabled" ]
                , ButtonGroup.radioButton
                    (switches.rfidReader2 == RfidReader2 Enabled)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            RfidReader2 Enabled
                    ]
                    [ text "Enabled" ]
                ]
            ]
        ]


viewDispenser : Settings -> Switches -> Table.Row Msg
viewDispenser settings switches =
    Table.tr []
        [ Table.td []
            [ text "Dispenser" ]
        , Table.td []
            [ ButtonGroup.radioButtonGroup []
                [ ButtonGroup.radioButton
                    (switches.dispenser == Dispenser Disabled)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            Dispenser Disabled
                    ]
                    [ text "Disabled" ]
                , ButtonGroup.radioButton
                    (switches.dispenser == Dispenser CRT_531)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            Dispenser CRT_531
                    ]
                    [ text "CRT 531" ]
                , ButtonGroup.radioButton
                    (switches.dispenser == Dispenser TCD_820M)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            Dispenser TCD_820M
                    ]
                    [ text "TCD 820M" ]
                ]
            ]
        ]


viewCardOut : Settings -> Switches -> Table.Row Msg
viewCardOut settings switches =
    Table.tr []
        [ Table.td []
            [ text "Card Out" ]
        , Table.td []
            [ ButtonGroup.radioButtonGroup []
                [ ButtonGroup.radioButton
                    (switches.cardOut == CardOut ToGate)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            CardOut ToGate
                    ]
                    [ text "To Gate" ]
                , ButtonGroup.radioButton
                    (switches.cardOut == CardOut FullOut)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            CardOut FullOut
                    ]
                    [ text "Full Out" ]
                ]
            ]
        ]


viewNetwork : Settings -> Switches -> Table.Row Msg
viewNetwork settings switches =
    Table.tr []
        [ Table.td []
            [ text "Network" ]
        , Table.td []
            [ ButtonGroup.radioButtonGroup []
                [ ButtonGroup.radioButton
                    (switches.network == Network None)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            Network None
                    ]
                    [ text "None" ]
                , ButtonGroup.radioButton
                    (switches.network == Network RS_485)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            Network RS_485
                    ]
                    [ text "RS 485" ]
                , ButtonGroup.radioButton
                    (switches.network == Network Can)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            Network Can
                    ]
                    [ text "Can" ]
                , ButtonGroup.radioButton
                    (switches.network == Network Ethernet)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            Network Ethernet
                    ]
                    [ text "Ethernet" ]
                , ButtonGroup.radioButton
                    (switches.network == Network WiFi)
                    [ Button.primary
                    , Button.onClick <|
                        ExchangeRadioMsg <|
                            Network WiFi
                    ]
                    [ text "WiFi" ]
                ]
            ]
        ]
