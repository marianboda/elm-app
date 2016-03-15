module Main (..) where

import Html exposing (Html)
import Html.Events as Events
import Debug

import StartApp.Simple

type alias Model =
  { chars: String, count: Int }

type Action
  = NoOp
  | Increase
  | KeyPress Int

initialModel : Model
initialModel = {
  chars = "",
  count = 0 }

view : Signal.Address Action -> Model -> Html
view address model =
  Html.div
    []
    [
      Html.div [] [Html.text (toString model.count)]
    , Html.button
        [ Events.onClick address Increase ]
        [ Html.text "Click"]
    ]

update : Action -> Model -> Model
update action model =
  case action of
    Increase -> { model | count = model.count +2 }
    NoOp -> model
    _ -> model

main : Signal.Signal Html

main =
  StartApp.Simple.start
    { model = initialModel
    , view = view
    , update = update
    }
