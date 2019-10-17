module Device exposing (Model)

import Bootstrap.Tab as Tab
import Html exposing (..)
import Html.Attributes
import Html.Events



-- MODEL


type alias Model =
    { device : Device
    , tabState : Tab.State
    }


type Device
    = Washbox WashboxData
    | Exchange ExchangeData


type alias WashboxData =
    { info : String
    , config : Int
    , counter : Int
    , log : Int
    }


type alias ExchangeData =
    { info : String
    , config : Int
    , counter : Int
    , log : Int
    }



--UPDATE


type Msg
    = ChangeConfig



-- VIEW


view : Model -> Html Msg
view model =
    let
        device =
            model.device
    in
    case device of
        Washbox data ->
            text "washbox"

        Exchange data ->
            text "exchange"
