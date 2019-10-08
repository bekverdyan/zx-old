module Carwash exposing (Carwash)


type alias Carwash =
    List Device


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
    ( Resource, Unit )


type alias Counter =
    ( Int, Int )



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



-- EXCHANGE


type alias ExchangeConfig =
    { coinNominal : Int
    , hopperCoinNominal : Int
    }


type alias ExchangeCounter =
    { billCash : Int
    , hopperCoin : Int
    }
