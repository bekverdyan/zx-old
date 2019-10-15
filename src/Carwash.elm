module Carwash exposing (Carwash, Device, Msg(..), testCarwashes, viewCarwashAsCard, viewDevice, viewDeviceAsListElement)

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
import Washbox


type alias Carwash =
    { id : String
    , name : String
    , devices : List Device
    }


type Device
    = Washbox ( DeviceInfo, Washbox.Washbox )
    | Exchange ( DeviceInfo, ExchangeConfig, ExchangeCounter )


type alias DeviceInfo =
    { deviceModel : String
    , deviceVersion : String
    , softVersion : String
    }



-- WASHBOX
-- UPDATE


type Msg
    = AccordionMsg Accordion.State
    | Washbox.TabMsg Tab.State
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
        Washbox ( info, washbox ) ->
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
        Washbox ( info, washbox ) ->
            Card.config []
                |> Card.block []
                    [ Block.titleH4 [] [ text "Սազան վայրագ" ]
                    , Block.text [] [ viewInfo info ]
                    , Block.custom <| Washbox.viewTabs washbox tabState
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



-- CONSTANTS
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


testDeviceInfos : List DeviceInfo
testDeviceInfos =
    [ { deviceModel = "Սամուիլ Արշակ"
      , deviceVersion = "4.0.12"
      , softVersion = "1.1.32"
      }
    , { deviceModel = "Դանիել Մաստուրբ"
      , deviceVersion = "3.2.7"
      , softVersion = "1.0.32"
      }
    ]


testCarwashes : List Carwash
testCarwashes =
    [ { id = "7465732"
      , name = "Քուչի Մոյկա"
      , devices =
            collectDevices testDeviceInfos Washbox.testWashboxes
      }
    ]


collectDevices : List DeviceInfo -> List Washbox.Washbox -> List Device
collectDevices deviceInfos washboxes =
    List.map toDevice (List.map2 Tuple.pair deviceInfos washboxes)


toDevice : ( DeviceInfo, Washbox.Washbox ) -> Device
toDevice ( deviceInfo, washbox ) =
    Washbox ( deviceInfo, washbox )
