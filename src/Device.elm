module Device exposing (Model)

import Bootstrap.Tab as Tab



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
    , log : Int
    }
