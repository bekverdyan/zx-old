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
    , showDevice : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model
        Carwash.testData
        { accordionState = Accordion.initialStateCardOpen "card1"
        , tabState = Tab.initialState
        , showDevice = True
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
                    , showDevice = model.states.showDevice
                    }
            in
            ( { model | states = states }, Cmd.none )

        Carwash.TabMsg tabState ->
            let
                states =
                    { accordionState = model.states.accordionState
                    , tabState = tabState
                    , showDevice = model.states.showDevice
                    }
            in
            ( { model | states = states }, Cmd.none )

        Carwash.SelectDevice device ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.map (\_ -> Carwash.OpenDevice) (text "")
        , Html.map (\_ -> Carwash.CarwashesOnly) (text "hghgh")
        ]


viewCarwashes : List Carwash.Carwash -> Accordion.State -> Html Msg
viewCarwashes carwashes accordionState =
    Grid.container []
        [ Grid.row []
            [ Grid.col []
                [ Accordion.config
                    Carwash.AccordionMsg
                    |> Accordion.withAnimation
                    |> Accordion.cards (List.map Carwash.viewCarwashAsCard carwashes)
                    |> Accordion.view accordionState
                ]
            ]
        ]


viewCarwashesWithSelectedDevice : List Carwash.Carwash -> Accordion.State -> Carwash.Device -> Tab.State -> Html Msg
viewCarwashesWithSelectedDevice carwashes accordionState device tabState =
    Grid.container []
        [ Grid.row []
            [ Grid.col []
                [ Accordion.config
                    Carwash.AccordionMsg
                    |> Accordion.withAnimation
                    |> Accordion.cards (List.map Carwash.viewCarwashAsCard carwashes)
                    |> Accordion.view accordionState
                ]
            , Grid.col [] []
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Accordion.subscriptions model.states.accordionState Carwash.AccordionMsg
