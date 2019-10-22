module Washbox exposing (Channels, Counters, Msg(..), channelsPreset, countersPreset, viewChannels, viewCounters)

import Bootstrap.Button as Button
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.Table as Table
import Html exposing (..)



--MODEL


type alias Counters =
    List Counter


type alias Counter =
    ( Float, Float )


type alias Channels =
    { actual : Int
    , defined : List Channel
    }


type alias Channel =
    ( Int, List Component )


type alias Component =
    { resource : Resource
    , unit : Unit
    , value : Float
    }


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



--HELPERS


countersPreset : Counters
countersPreset =
    [ ( 0, 0 )
    , ( 0, 0 )
    , ( 0, 0 )
    , ( 0, 0 )
    , ( 0, 0 )
    , ( 0, 0 )
    ]


channelsPreset : Channels
channelsPreset =
    { actual = 6
    , defined =
        [ ( 1
          , [ { resource = Water
              , unit = Liter
              , value = 0
              }
            ]
          )
        ]
    }


unitName : Unit -> String
unitName unit =
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


resourceName : Resource -> String
resourceName resource =
    case resource of
        Electricity ->
            "Electricity"

        Water ->
            "Water"

        Foam ->
            "Foam"

        Wood ->
            "Wood"



--UPDATE


type Msg
    = WashboxMsg Resource



-- VIEW


viewCounters : List Counter -> Html Msg
viewCounters counters =
    Table.table
        { options = [ Table.striped, Table.hover ]
        , thead = Table.thead [] []
        , tbody =
            Table.tbody [] <|
                List.map viewCounter counters
        }


viewCounter : Counter -> Table.Row Msg
viewCounter counter =
    Table.tr []
        [ Table.td []
            [ text (String.fromFloat (Tuple.first counter)) ]
        , Table.td []
            [ text (String.fromFloat (Tuple.second counter)) ]
        ]


viewChannels : Channels -> Html Msg
viewChannels channels =
    div [] <| List.map viewChannel channels.defined


viewChannel : Channel -> Html Msg
viewChannel channel =
    Card.config [ Card.outlineDark ]
        |> Card.headerH3 []
            [ text <|
                String.append "Channel " <|
                    String.fromInt <|
                        Tuple.first channel
            ]
        |> Card.block []
            (List.map viewComponent <|
                Tuple.second channel
            )
        |> Card.view


viewComponent : Component -> Block.Item Msg
viewComponent component =
    Block.custom
        (InputGroup.config
            (InputGroup.number
                [ Input.placeholder "Number"
                , Input.value <|
                    String.fromFloat component.value
                ]
            )
            |> InputGroup.successors
                [ InputGroup.button
                    [ Button.secondary
                    , Button.onClick <|
                        WashboxMsg component.resource
                    ]
                    [ text "Save" ]
                ]
            |> InputGroup.view
        )
