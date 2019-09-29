module Main exposing (Model, init, main)

import Bootstrap.Alert as Alert
import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Utilities.Spacing as Spacing
import Browser
import Debug
import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as D
import Json.Encode as E


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }



-- MODEL


type alias Model =
    { carwashes : Maybe (List Carwash) }


type Carwash
    = List Device


type Device
    = Washbox ( DeviceInfo, WashboxConfig, WashboxCounter )
    | Exchange ( DeviceInfo, ExchangeConfig, ExchangeCounter )


type alias DeviceInfo =
    { deviceModel : String
    , deviceVersion : String
    , softVersion : String
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
    { channelCount : Int }


type alias WashboxCounter =
    { coinCash : Int }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Nothing, Cmd.none )


type Msg
    = SamuilArshak



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SamuilArshak ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    text "gago"
