module Device exposing (Model)

import Bootstrap.Tab as Tab
import Bootstrap.Utilities.Spacing as Spacing
import Exchange
import Html exposing (..)
import Washbox



-- MODEL


type alias Model =
    { device : Device
    , tabState : Tab.State
    }


type alias Device =
    { info : String
    , device : Type
    , log : Int
    }


type Type
    = Savok Exchange.Counters
    | Exchangeik Washbox.Channels



--UPDATE


type Msg
    = ChangeConfig
    | TabMsg Tab.State



-- VIEW


view : Model -> Tab.State -> Html Msg
view model tabState =
    let
        device =
            model.device
    in
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
