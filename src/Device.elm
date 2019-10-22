module Device exposing (Common, Msg, view)

import Bootstrap.Tab as Tab
import Bootstrap.Utilities.Spacing as Spacing
import Exchange
import Html exposing (..)
import Washbox



-- MODEL


type alias Model =
    { device : Common
    , tabState : Tab.State
    }


type alias Common =
    { info : String
    , counters : Counters
    , configs : Configs
    , log : Int
    }


type Counters
    = WashboxCounters Washbox.Counters
    | ExchangeCounters Exchange.Counters


type Configs
    = WashboxConfigs Washbox.Channels
    | ExchangeConfigs Exchange.Settings



--UPDATE


type Msg
    = TabMsg Tab.State
    | WashboxMsg Washbox.Resource



-- VIEW


view : Model -> Html Msg
view model =
    viewTab ( model.device.counters, model.device.configs ) model.tabState


viewTab : ( Counters, Configs ) -> Tab.State -> Html Msg
viewTab ( counters, configs ) tabState =
    Tab.config
        TabMsg
        |> Tab.items
            [ Tab.item
                { id = "counters"
                , link = Tab.link [] [ text "Counters" ]
                , pane =
                    Tab.pane [ Spacing.mt3 ]
                        [ text "counters" ]
                }
            , Tab.item
                { id = "settings"
                , link = Tab.link [] [ text "Settings" ]
                , pane =
                    Tab.pane [ Spacing.mt3 ]
                        [ text "configs" ]
                }
            ]
        |> Tab.view tabState



-- viewConfigs : Configs -> Html Msg
-- viewConfigs configs =
--     case configs of
--         WashboxConfigs channels ->
--             Washbox.viewChannels channels
--         Exchange
