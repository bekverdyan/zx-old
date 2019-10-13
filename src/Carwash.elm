module Carwash exposing (Carwash, Msg(..), testData, viewCarwashAsCard, viewDevice, viewDeviceAsListElement)

import Bootstrap.Accordion as Accordion
import Bootstrap.Button as Button
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Tab as Tab
import Bootstrap.Table as Table
import Bootstrap.Text as Text
import Bootstrap.Utilities.Spacing as Spacing
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Carwash =
    { id : String
    , name : String
    , devices : List Device
    }


type Device
    = Washbox ( DeviceInfo, WashboxConfig, WashboxCounter )
    | Exchange ( DeviceInfo, ExchangeConfig, ExchangeCounter )


type alias DeviceInfo =
    { deviceModel : String
    , deviceVersion : String
    , softVersion : String
    }



-- WASHBOX
-- Int value represents the total number of device inputs


type alias WashboxConfig =
    ( DefinedChannels, Int )



-- The Int value of a tuple is count cash indicator


type alias WashboxCounter =
    List Counter


type alias DefinedChannels =
    List Channel



-- Int value represents the channel number


type alias Channel =
    ( List Component, Int )


type alias Component =
    ( Resource, Unit, Float )


type alias Counter =
    ( Int, Int )



-- UPDATE


type Msg
    = AccordionMsg Accordion.State
    | TabMsg Tab.State
    | SelectDevice Device



-- VIEW


viewCarwashAsCard : Carwash -> Accordion.Card Msg
viewCarwashAsCard carwash =
    Accordion.card
        { id = carwash.id
        , options = [ Card.outlineSuccess, Card.align Text.alignXsCenter ]
        , header =
            Accordion.headerH3 []
                (Accordion.toggle [] [ text carwash.name ])
                |> Accordion.prependHeader
                    [ span [ class "fa fa-taxi" ] [] ]
        , blocks =
            [ Accordion.listGroup <| List.map viewDeviceAsListElement carwash.devices ]
        }


viewDeviceAsListElement : Device -> ListGroup.Item Msg
viewDeviceAsListElement device =
    case device of
        Washbox ( info, configs, counters ) ->
            ListGroup.li []
                [ Button.button
                    [ Button.light
                    , Button.attrs [ onClick <| SelectDevice device ]
                    ]
                    [ text info.deviceModel ]
                ]

        Exchange ( info, configs, counters ) ->
            ListGroup.li [] [ text "gago" ]


viewDevice : Device -> Tab.State -> Html Msg
viewDevice device tabState =
    case device of
        Washbox ( info, configs, counters ) ->
            Card.config []
                |> Card.block []
                    [ Block.titleH4 [] [ text "Սազան վայրագ" ]
                    , Block.text [] [ viewInfo info ]
                    , Block.custom <| viewTabs configs counters tabState
                    ]
                |> Card.view

        Exchange ( info, configs, counters ) ->
            text "gago"


viewInfo : DeviceInfo -> Html Msg
viewInfo info =
    div []
        [ span [] [ text <| "Model: " ++ info.deviceModel ]
        , span [] [ text <| "Version: " ++ info.deviceVersion ]
        , span [] [ text <| "Soft version: " ++ info.softVersion ]
        ]


viewTabs : WashboxConfig -> WashboxCounter -> Tab.State -> Html Msg
viewTabs configs counters tabState =
    Tab.config
        TabMsg
        |> Tab.items
            [ Tab.item
                { id = "counters"
                , link = Tab.link [] [ text "Counters" ]
                , pane = Tab.pane [ Spacing.mt3 ] [ viewCounters counters ]
                }
            , Tab.item
                { id = "configs"
                , link = Tab.link [] [ text "Configs" ]
                , pane = Tab.pane [ Spacing.mt3 ] [ viewConfigs configs ]
                }
            ]
        |> Tab.view tabState


viewConfigs : WashboxConfig -> Html Msg
viewConfigs ( definedChannels, channels ) =
    Card.columns (List.map viewChannel definedChannels)


viewChannel : Channel -> Card.Config Msg
viewChannel ( components, channelNumber ) =
    Card.config []
        |> Card.headerH3 []
            [ text <|
                String.append "Channel " <|
                    String.fromInt channelNumber
            ]
        |> Card.listGroup
            (List.map viewComponent components)


viewComponent : Component -> ListGroup.Item Msg
viewComponent ( resource, unit, value ) =
    ListGroup.li []
        [ InputGroup.config
            (InputGroup.number
                [ Input.placeholder "value"
                , Input.value <| String.fromFloat value
                ]
            )
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text <| resourceToString resource ] ]
            |> InputGroup.successors
                [ InputGroup.span [] [ text <| unitToString unit ] ]
            |> InputGroup.view
        ]


viewCounters : WashboxCounter -> Html Msg
viewCounters counters =
    Table.table
        { options = [ Table.striped, Table.hover ]
        , thead = Table.thead [] []
        , tbody = Table.tbody [] (List.map viewCounter counters)
        }


viewCounter : Counter -> Table.Row Msg
viewCounter counter =
    Table.tr []
        [ Table.td [] [ text (String.fromInt (Tuple.first counter)) ]
        , Table.td [] [ text (String.fromInt (Tuple.second counter)) ]
        ]



-- CONSTANTS


type Unit
    = Meter
    | Liter
    | Kilowatt
    | CubicMetre
    | Gram
    | Second


type Resource
    = Electricity
    | Water
    | Foam
    | Wood


unitToString : Unit -> String
unitToString unit =
    case unit of
        Meter ->
            "Meter"

        Liter ->
            "Liter"

        Kilowatt ->
            "Kilowatt"

        CubicMetre ->
            "CubicMetre"

        Gram ->
            "Gram"

        Second ->
            "Second"


resourceToString : Resource -> String
resourceToString resource =
    case resource of
        Electricity ->
            "Electricity"

        Water ->
            "Water"

        Foam ->
            "Foam"

        Wood ->
            "Wood"



-- EXCHANGE


type alias ExchangeConfig =
    { coinNominal : Int
    , hopperCoinNominal : Int
    }


type alias ExchangeCounter =
    { billCash : Int
    , hopperCoin : Int
    }



-- STATIC DATA


testData : List Carwash
testData =
    [ { id = "7465732"
      , name = "քուչի մոյկա"
      , devices =
            [ Washbox
                ( { deviceModel = "samuil arshak"
                  , deviceVersion = "4.0.12"
                  , softVersion = "1.1.32"
                  }
                , ( [ ( [ ( Electricity, Kilowatt, 32.3 )
                        , ( Water, Liter, 7 )
                        , ( Foam, Gram, 4.8 )
                        ]
                      , 3
                      )
                    , ( [ ( Electricity, Kilowatt, 3.14 )
                        , ( Water, Liter, 20 )
                        ]
                      , 5
                      )
                    , ( [ ( Wood, CubicMetre, 8 ) ], 6 )
                    ]
                  , 6
                  )
                , [ ( 1, 1270 )
                  , ( 5, 4532 )
                  , ( 6, 1234 )
                  ]
                )
            , Washbox
                ( { deviceModel = "daniel mastrurb"
                  , deviceVersion = "4.1.10"
                  , softVersion = "2.1.0"
                  }
                , ( [ ( [ ( Electricity, Kilowatt, 123 )
                        , ( Water, Liter, 32 )
                        , ( Foam, Gram, 0.95 )
                        ]
                      , 1
                      )
                    , ( [ ( Wood, CubicMetre, 5 )
                        , ( Electricity, Kilowatt, 777 )
                        ]
                      , 6
                      )
                    ]
                  , 5
                  )
                , [ ( 1, 4278 )
                  , ( 5, 1870 )
                  , ( 2, 3910 )
                  ]
                )
            ]
      }
    ]
