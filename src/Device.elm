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


type alias Device =
    { info : String
    , config : Config
    , counter : Counter
    , log : Int
    }


type Config
    = Washbox Int (List Channel)
    | Exchange Int Int


type alias Counter =
    { channelId : Int
    , component : Component
    , pointer : Int
    }


type alias ExchangeConfig =
    { coinNominal : Int
    , hopperCoinNominal : Int
    }


type alias ExchangeCounter =
    { billCash : Int
    , hopperCoin : Int
    }


type alias WashboxConfig =
    { definedChannels : List Channel
    , actualChannels : Int
    }


type alias Channel =
    { id : Int
    , components : List Component
    }


type alias Component =
    { type_ : String
    , unit : String
    }


type alias WashboxCounter =
    List CounterData


type alias CounterData =
    { channelId : Int
    , pointer : Int
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
    text device.info
