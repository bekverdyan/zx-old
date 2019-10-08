module Carwash exposing (Carwash)

import Html exposing (..)


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
    ( Resource, Unit, Float )


type alias Counter =
    ( Int, Int )



-- UPDATE


type Msg
    = DeviceDetails



-- VIEW


viewCounter : Counter -> Html Msg
viewCounter counter =
    text "gago"



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
            , ( [ ( [ ( Electricity, Kilowatt, 32.3 )
                    , ( Water, Liter, 7 )
                    , ( Foam, Gram, 4.8 )
                    ]
                  , 3
                  )
                , ( [ ( Electricity, Kilowatt, 3.14 )
                    , ( Water, Liter, 20 )
                    ]
                  , 5
                  )
                , ( [ ( Wood, CubicMetre, 8 ) ], 6 )
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
            , ( [ ( [ ( Electricity, Kilowatt, 123 )
                    , ( Water, Liter, 32 )
                    , ( Foam, Gram, 0.95 )
                    ]
                  , 1
                  )
                , ( [ ( Wood, CubicMetre, 5 )
                    , ( Electricity, Kilowatt, 777 )
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
