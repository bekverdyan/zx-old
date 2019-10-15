module Constants exposing (Resource(..), Unit(..), resourceToString, unitToString)


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


unitToString : Unit -> String
unitToString unit =
    case unit of
        Meter ->
            "Meter"

        Liter ->
            "Liter"

        Kilowatt ->
            "Kilowatt"

        CubicMetre ->
            "CubicMetre"

        Gram ->
            "Gram"

        Second ->
            "Second"


resourceToString : Resource -> String
resourceToString resource =
    case resource of
        Electricity ->
            "Electricity"

        Water ->
            "Water"

        Foam ->
            "Foam"

        Wood ->
            "Wood"



-- STATIC DATA


testData : List Carwash
testData =
    [ { id = "7465732"
      , name = "քուչի մոյկա"
      , devices =
            [ Washbox
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
      }
    ]
