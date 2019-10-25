module Branch exposing (Model, Msg(..), init, subscriptions, updateAccordion, view)

import Bootstrap.Accordion as Accordion
import Bootstrap.Button as Button
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Grid as Grid
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Text as Text
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MODEL


type alias Model =
    { carwashes : List Carwash
    , accordionState : Accordion.State
    }


type alias Carwash =
    { id : String
    , name : String
    , devices : List Label
    }


type alias Label =
    { id : String
    , name : String
    , actualChannels : Int
    , definedChannels : Int
    }


type Msg
    = AccordionMsg Accordion.State
    | OnDeviceSelect String



-- TODO Implement http receiver


init : Model
init =
    Model [] <| Accordion.initialStateCardOpen "card1"


updateAccordion : Accordion.State -> Model -> Model
updateAccordion state model =
    { model | accordionState = state }



-- VIEW


view : Model -> Html Msg
view model =
    viewCarwashes model.carwashes model.accordionState


viewCarwashes : List Carwash -> Accordion.State -> Html Msg
viewCarwashes carwashes accordionState =
    Grid.container []
        [ Grid.row []
            [ Grid.col []
                [ Accordion.config
                    AccordionMsg
                    |> Accordion.withAnimation
                    |> Accordion.cards (List.map viewCarwash carwashes)
                    |> Accordion.view accordionState
                ]
            ]
        ]


viewCarwash : Carwash -> Accordion.Card Msg
viewCarwash carwash =
    Accordion.card
        { id = carwash.id
        , options = [ Card.outlineSuccess, Card.align Text.alignXsCenter ]
        , header =
            Accordion.headerH3 []
                (Accordion.toggle [] [ text carwash.name ])
                |> Accordion.prependHeader
                    [ span [ class "fa fa-taxi" ] [] ]
        , blocks =
            [ Accordion.listGroup <| List.map viewDeviceLabel carwash.devices ]
        }


viewDeviceLabel : Label -> ListGroup.Item Msg
viewDeviceLabel device =
    ListGroup.li []
        [ Button.button
            [ Button.light
            , Button.attrs [ onClick <| OnDeviceSelect device.id ]
            ]
            [ text device.name ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Accordion.subscriptions model.accordionState AccordionMsg
