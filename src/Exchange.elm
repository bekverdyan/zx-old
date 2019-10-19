module Exchange exposing (Model)

import Bootstrap.Button as Button
import Bootstrap.ButtonGroup as ButtonGroup
import Bootstrap.Table as Table
import Html exposing (..)



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
    , hopper : Int
    , hopperCoinNominal : Int
    , hopperMode : Int
    , billValidator : Int
    , billNominal : List Int
    , rfidReader1 : Int
    , rfidReader2 : Int
    , dispenser : Int
    , cardOut : Int
    , cardPrice : Int
    , network : Int
    , deviceId : String
    , serverCode : String
    , bonusPercent : Int
    , bonusThreshold : Int
    }



-- HELPERS


defaultCounters : Counters
defaultCounters =
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


defaultSettings : Settings
defaultSettings =
    { coinNominal = 0
    , hopper = disabled -- Hopper state disabled | ccTalk | Pulse
    , hopperCoinNominal = 0
    , hopperMode = mode1 -- mode1 | mode2
    , billValidator = disabled -- disabled | ccTalk
    , billNominal = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] -- array of 10 integers
    , rfidReader1 = disabled -- disabled | enabled
    , rfidReader2 = disabled -- disabled | enabled
    , dispenser = disabled -- disabled | crt531 | tcd820M
    , cardOut = toGate -- toGate | fullOut
    , cardPrice = 0
    , network = none -- none | rs485 | can | ethernet | wifi
    , deviceId = ""
    , serverCode = ""
    , bonusPercent = 0
    , bonusThreshold = 0
    }


enabled : Int
enabled =
    1


disabled : Int
disabled =
    0


ccTalk : Int
ccTalk =
    1


pulse : Int
pulse =
    2


mode1 : Int
mode1 =
    0


mode2 : Int
mode2 =
    1


crt531 : Int
crt531 =
    1


tcd820M : Int
tcd820M =
    2


toGate : Int
toGate =
    0


fullOut : Int
fullOut =
    1


none : Int
none =
    0


rs485 : Int
rs485 =
    1


can : Int
can =
    2


ethernet : Int
ethernet =
    3


wifi : Int
wifi =
    4



--UPDATE


type Msg
    = SaveSetting
    | RadioMsg Switch


type Setting
    = Int
    | String
    | Swithch


type Switch
    = Hopper Faze
    | HopperMode Faze
    | BillValidator Faze
    | BillNominal Faze
    | RfidReader1 Faze
    | RfidReader2 Faze
    | Dispenser Faze
    | CardOut Faze
    | Network Faze


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
    case msg of
        RadioMsg switch ->
            let
                settings =
                    model.exchange.settings
            in
            case switch of
                Hopper faze ->
                    ( changeSettings (setHopper faze settings) model, Nothing )

                HopperMode faze ->
                    ( changeSettings (setHopperMode faze settings) model, Nothing )

                BillValidator faze ->
                    ( changeSettings (setBillValidator faze settings) model, Nothing )

                BillNominal faze ->
                    ( changeSettings (setBillNominal faze settings) model, Nothing )

                RfidReader1 faze ->
                    ( changeSettings (setRfidReader1 faze settings) model, Nothing )

                RfidReader2 faze ->
                    ( changeSettings (setRfidReader2 faze settings) model, Nothing )

                Dispenser faze ->
                    ( changeSettings (setDispenser faze settings) model, Nothing )

                CardOut faze ->
                    ( changeSettings (setCardOut faze settings) model, Nothing )

                Network faze ->
                    ( changeSettings (setNetwork faze settings) model, Nothing )

        SaveSetting ->
            ( model, Nothing )


changeSettings : Settings -> Model -> Model
changeSettings settings model =
    let
        exchange =
            model.exchange
    in
    { model | exchange = { exchange | settings = settings } }


setHopper : Faze -> Settings -> Settings
setHopper faze settings =
    case faze of
        Disabled ->
            { settings | hopper = 0 }

        CcTalk ->
            { settings | hopper = 1 }

        Pulse ->
            { settings | hopper = 2 }

        _ ->
            settings


setHopperMode : Faze -> Settings -> Settings
setHopperMode faze settings =
    case faze of
        Mode_1 ->
            { settings | hopperMode = 0 }

        Mode_2 ->
            { settings | hopperMode = 1 }

        _ ->
            settings


setBillValidator : Faze -> Settings -> Settings
setBillValidator faze settings =
    case faze of
        Disabled ->
            { settings | billValidator = 0 }

        CcTalk ->
            { settings | billValidator = 1 }

        _ ->
            settings


setBillNominal : Faze -> Settings -> Settings
setBillNominal faze settings =
    case faze of
        _ ->
            settings


setRfidReader1 : Faze -> Settings -> Settings
setRfidReader1 faze settings =
    case faze of
        Disabled ->
            { settings | rfidReader1 = 0 }

        Enabled ->
            { settings | rfidReader1 = 1 }

        _ ->
            settings


setRfidReader2 : Faze -> Settings -> Settings
setRfidReader2 faze settings =
    case faze of
        Disabled ->
            { settings | rfidReader2 = 0 }

        Enabled ->
            { settings | rfidReader2 = 1 }

        _ ->
            settings


setDispenser : Faze -> Settings -> Settings
setDispenser faze settings =
    case faze of
        Disabled ->
            { settings | dispenser = 0 }

        CRT_531 ->
            { settings | dispenser = 1 }

        TCD_820M ->
            { settings | dispenser = 2 }

        _ ->
            settings


setCardOut : Faze -> Settings -> Settings
setCardOut faze settings =
    case faze of
        ToGate ->
            { settings | cardOut = 0 }

        FullOut ->
            { settings | cardOut = 1 }

        _ ->
            settings


setNetwork : Faze -> Settings -> Settings
setNetwork faze settings =
    case faze of
        None ->
            { settings | network = 0 }

        RS_485 ->
            { settings | network = 1 }

        Can ->
            { settings | network = 2 }

        Ethernet ->
            { settings | network = 3 }

        WiFi ->
            { settings | network = 4 }

        _ ->
            settings



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


viewSettings : Settings -> Html Msg
viewSettings settings =
    Table.table
        { options = []
        , thead = Table.thead [] []
        , tbody =
            Table.tbody []
                []
        }



-- viewSetting : Setting -> String -> Html Msg
-- viewSetting dvijeni name =
--     ButtonGroup.radioButtonGroup []
--         [ ButtonGroup.radioButton
--             (model.radioState == One)
--             [ Button.primary, Button.onClick <| RadioMsg One ]
--             [ text "One" ]
--         , ButtonGroup.radioButton
--             (model.radioState == Two)
--             [ Button.primary, Button.onClick <| RadioMsg Two ]
--             [ text "Two" ]
--         , ButtonGroup.radioButton
--             (model.radioState == Three)
--             [ Button.primary, Button.onClick <| RadioMsg Three ]
--             [ text "Three" ]
--         ]
