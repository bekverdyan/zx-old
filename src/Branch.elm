module Branch exposing (CarwashMsg(..))

import Bootstrap.Accordion as Accordion


type alias Carwash =
    { id : String
    , name : String
    , devices : List Label
    }


type alias Label =
    { id : String
    , name : String
    , actualChannels : Int
    , definedChannels : Int
    }


type CarwashMsg
    = Smbulik String
    | Samazvan Int
    | Lolik


type Msg
    = AccordionMsg Accordion.State
    | OnDeviceSelect String
