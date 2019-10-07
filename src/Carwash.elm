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


type WashboxConfig
    = List Channel



-- The Int value of a tuple is coun cash indicator


type alias WashboxCounter =
    ( List Channel, Int )



-- Int value represents the channel number


type Channel
    = Maybe ( List Component, Int )


type alias Component =
    { resource : Resource
    , unit : Unit
    }


type Unit
    = Meter
    | Liter
    | Kilowatt
    | CubicMetre
    | Gram


type Resource
    = Electricity
    | Water
    | Foam



-- EXCHANGE


type alias ExchangeConfig =
    { coinNominal : Int
    , hopperCoinNominal : Int
    }


type alias ExchangeCounter =
    { billCash : Int
    , hopperCoin : Int
    }
