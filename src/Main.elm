module Main exposing (Model, init, main)

import Bootstrap.Accordion as Accordion
import Bootstrap.Alert as Alert
import Bootstrap.Button as Button
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Tab as Tab
import Bootstrap.Text as Text
import Bootstrap.Utilities.Spacing as Spacing
import Browser
import Carwash as Carwash
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
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { carwashes : List Carwash.Carwash
    , states : States
    }


type alias States =
    { accordionState : Accordion.State
    , tabState : Tab.State
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model
        Carwash.testData
        { accordionState = Accordion.initialStateCardOpen "card1"
        , tabState = Tab.initialState
        }
    , Cmd.none
    )


type alias Msg =
    Carwash.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Carwash.AccordionMsg accordionState ->
            let
                states =
                    { accordionState = accordionState
                    , tabState = model.states.tabState
                    }
            in
            ( { model | states = states }, Cmd.none )

        Carwash.TabMsg tabState ->
            let
                states =
                    { accordionState = model.states.accordionState
                    , tabState = tabState
                    }
            in
            ( { model | states = states }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    Accordion.config Carwash.AccordionMsg
        |> Accordion.withAnimation
        |> Accordion.cards (List.map Carwash.viewCarwashAsCard model.carwashes)
        |> Accordion.view model.states.accordionState


subscriptions : Model -> Sub Msg
subscriptions model =
    Accordion.subscriptions model.states.accordionState Carwash.AccordionMsg
