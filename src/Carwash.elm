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



-- STATIC DATA


testData : List Carwash
testData =
    [ [ Washbox
            ( { deviceModel = "samuil arshak"
              , deviceVersion = "4.0.12"
              , softVersion = "1.1.32"
              }
            , ( [ ( [ ( Electricity, Kilowatt )
                    , ( Water, Liter )
                    , ( Foam, Gram )
                    ]
                  , 3
                  )
                , ( [ ( Electricity, Kilowatt )
                    , ( Water, Liter )
                    ]
                  , 5
                  )
                , ( [ ( Wood, CubicMetre ) ], 6 )
                ]
              , 6
              )
            , [ ( 1, 1270 )
              , ( 5, 4532 )
              , ( 6, 1234 )
              ]
            )
      , Washbox
            ( { deviceModel = "daniel mastrurb"
              , deviceVersion = "4.1.10"
              , softVersion = "2.1.0"
              }
            , ( [ ( [ ( Electricity, Kilowatt )
                    , ( Water, Liter )
                    , ( Foam, Gram )
                    ]
                  , 1
                  )
                , ( [ ( Wood, CubicMetre )
                    , ( Electricity, Kilowatt )
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
    ]
