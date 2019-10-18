module Exchange exposing (Model)

--MODEL


type alias Model =
    { counters : Counters
    , settings : Settings
    }


type alias Counters =
    { billCach : ( Int, Int )
    , coinCach : ( Int, Int )
    , cardRechargeCach : ( Int, Int )
    , soldCardCach : ( Int, Int )
    , cardDispense : ( Int, Int )
    , faultyCard : ( Int, Int )
    , coinHopperCoin : ( Int, Int )
    , coinHopperValue : ( Int, Int )
    , bonusCache : ( Int, Int )
    }


type alias Settings =
    { coinNominal : Int
    , hopper : Int
    , hopperCoinNominal : Int
    , hopperMode : Int
    , billValidator : Int
    , billNominal : List Int
    , rfidReader1 : Int
    , rfidReader2 : Int
    , dispenser : Int
    , cardOut : Int
    , cardPrice : Int
    , network : Int
    , deviceId : String
    , serverCode : String
    , bonusPercent : Int
    , bonusThreshold : Int
    }



-- HELPERS


defaultCounters : Counters
defaultCounters =
    { billCach = ( 0, 0 )
    , coinCach = ( 0, 0 )
    , cardRechargeCach = ( 0, 0 )
    , soldCardCach = ( 0, 0 )
    , cardDispense = ( 0, 0 )
    , faultyCard = ( 0, 0 )
    , coinHopperCoin = ( 0, 0 )
    , coinHopperValue = ( 0, 0 )
    , bonusCache = ( 0, 0 )
    }


defaultSettings : Settings
defaultSettings =
    { coinNominal = 0
    , hopper = disabled -- Hopper state disabled | ccTalk | Pulse
    , hopperCoinNominal = 0
    , hopperMode = mode1 -- mode1 | mode2
    , billValidator = disabled -- disabled | ccTalk
    , billNominal = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] -- array of 10 integers
    , rfidReader1 = disabled -- disabled | enabled
    , rfidReader2 = disabled -- disabled | enabled
    , dispenser = disabled -- disabled | crt531 tcd820M
    , cardOut = toGate -- toGate | fullOut
    , cardPrice = 0
    , network = none -- none | rs485 | can | ethernet | wifi
    , deviceId = ""
    , serverCode = ""
    , bonusPercent = 0
    , bonusThreshold = 0
    }


enabled : Int
enabled =
    1


disabled : Int
disabled =
    0


ccTalk : Int
ccTalk =
    1


pulse : Int
pulse =
    1


mode1 : Int
mode1 =
    0


mode2 : Int
mode2 =
    1


crt531 : Int
crt531 =
    1


tcd820M : Int
tcd820M =
    2


toGate : Int
toGate =
    0


fullOut : Int
fullOut =
    1


none : Int
none =
    0


rs485 : Int
rs485 =
    1


can : Int
can =
    2


ethernet : Int
ethernet =
    3


wifi : Int
wifi =
    4



-- VIEW
