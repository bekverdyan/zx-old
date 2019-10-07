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
    { carwashes : Maybe (List Carwash.Carwash)
    , accordionState : Accordion.State
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Nothing (Accordion.initialStateCardOpen "card1"), Cmd.none )


type Msg
    = AccordionMsg Accordion.State



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AccordionMsg accordionState ->
            ( { model | accordionState = accordionState }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    Accordion.config AccordionMsg
        |> Accordion.withAnimation
        |> Accordion.cards
            [ Accordion.card
                { id = "card1"
                , options =
                    [ Card.outlineSuccess
                    , Card.align Text.alignXsCenter
                    ]
                , header =
                    Accordion.headerH3 []
                        (Accordion.toggle [] [ text " Card 1" ])
                        |> Accordion.prependHeader
                            [ span [ class "fa fa-car" ] [] ]
                , blocks =
                    [ Accordion.block [ Block.align Text.alignXsLeft ]
                        [ Block.titleH4 [] [ text "Block title" ]
                        , Block.text [] [ text "Lorem ipsum etc" ]
                        ]
                    , Accordion.block [ Block.align Text.alignXsRight ]
                        [ Block.titleH4 [] [ text "Block2 title" ]
                        , Block.text [] [ text "Lorem ipsum etc" ]
                        ]
                    ]
                }
            , Accordion.card
                { id = "card2"
                , options = [ Card.outlineSuccess, Card.align Text.alignXsCenter ]
                , header =
                    Accordion.headerH3 []
                        (Accordion.toggle [] [ text " Card 2" ])
                        |> Accordion.prependHeader
                            [ span [ class "fa fa-taxi" ] [] ]
                , blocks =
                    [ Accordion.block []
                        [ Block.text [] [ text "Lorem ipsum etc" ] ]
                    , Accordion.listGroup
                        [ ListGroup.li [] [ text "List item 1" ]
                        , ListGroup.li [] [ text "List item 2" ]
                        ]
                    ]
                }
            ]
        |> Accordion.view model.accordionState


subscriptions : Model -> Sub Msg
subscriptions model =
    Accordion.subscriptions model.accordionState AccordionMsg
