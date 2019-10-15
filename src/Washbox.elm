module Washbox exposing (Msg(..), Washbox, testWashboxes, viewTabs)

-- import Constants.Unit as Unit
-- import Constants.Resource as Resource

import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.Tab as Tab
import Bootstrap.Table as Table
import Bootstrap.Utilities.Spacing as Spacing
import Constants
import Html exposing (..)


type alias Washbox =
    ( WashboxConfig, WashboxCounter )



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
    ( Constants.Resource, Constants.Unit, Float )


type alias Counter =
    ( Int, Int )


type Msg
    = TabMsg Tab.State


viewTabs : Washbox -> Tab.State -> Html Msg
viewTabs washbox tabState =
    Tab.config
        TabMsg
        |> Tab.items
            [ Tab.item
                { id = "counters"
                , link = Tab.link [] [ text "Counters" ]
                , pane = Tab.pane [ Spacing.mt3 ] [ viewCounters <| Tuple.second washbox ]
                }
            , Tab.item
                { id = "configs"
                , link = Tab.link [] [ text "Configs" ]
                , pane = Tab.pane [ Spacing.mt3 ] [ viewConfigs <| Tuple.first washbox ]
                }
            ]
        |> Tab.view tabState


viewConfigs : WashboxConfig -> Html Msg
viewConfigs ( definedChannels, channels ) =
    div [] <| List.map viewChannel definedChannels


viewChannel : Channel -> Html Msg
viewChannel ( components, channelNumber ) =
    Card.config [ Card.outlineDark ]
        |> Card.headerH3 []
            [ text <|
                String.append "Channel " <|
                    String.fromInt channelNumber
            ]
        |> Card.block [] (List.map viewComponent components)
        |> Card.view


viewComponent : Component -> Block.Item Msg
viewComponent ( resource, unit, value ) =
    Block.custom
        (InputGroup.config
            (InputGroup.number
                [ Input.placeholder "value"
                , Input.value <| String.fromFloat value
                ]
            )
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text <| Constants.resourceToString resource ] ]
            |> InputGroup.successors
                [ InputGroup.span [] [ text <| Constants.unitToString unit ] ]
            |> InputGroup.view
        )


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



-- STATIC DATA


testWashboxes : List Washbox
testWashboxes =
    [ ( ( [ ( [ ( Constants.Electricity, Constants.Kilowatt, 32.3 )
              , ( Constants.Water, Constants.Liter, 7 )
              , ( Constants.Foam, Constants.Gram, 4.8 )
              ]
            , 3
            )
          , ( [ ( Constants.Electricity, Constants.Kilowatt, 3.14 )
              , ( Constants.Water, Constants.Liter, 20 )
              ]
            , 5
            )
          , ( [ ( Constants.Wood, Constants.CubicMetre, 8 ) ], 6 )
          ]
        , 6
        )
      , [ ( 1, 1270 )
        , ( 5, 4532 )
        , ( 6, 1234 )
        ]
      )
    , ( ( [ ( [ ( Constants.Electricity, Constants.Kilowatt, 123 )
              , ( Constants.Water, Constants.Liter, 32 )
              , ( Constants.Foam, Constants.Gram, 0.95 )
              ]
            , 1
            )
          , ( [ ( Constants.Wood, Constants.CubicMetre, 5 )
              , ( Constants.Electricity, Constants.Kilowatt, 777 )
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
