module Main exposing (Model, init, main)

import Bootstrap.Accordion as Accordion
import Branch
import Browser
import Device
import Html exposing (..)


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



--MODEL


type alias Model =
    { branchModel : Branch.Model
    , deviceModel : Maybe Device.Model
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model
        Branch.init
      <|
        Just Device.init
    , Cmd.none
    )


type Msg
    = HandleBranch Branch.Msg
    | HandleDevice
    | HandleAccordion Accordion.State



--UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HandleAccordion state ->
            let
                newBranch =
                    Branch.updateAccordion
                        state
                        model.branchModel
            in
            ( { model | branchModel = newBranch }, Cmd.none )

        _ ->
            ( model, Cmd.none )



--VIEW


view : Model -> Html Msg
view model =
    text ""


subscriptions : Model -> Sub Msg
subscriptions model =
    Accordion.subscriptions model.branchModel.accordionState HandleAccordion
