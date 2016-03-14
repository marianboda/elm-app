module Main (..) where

import Html exposing (Html)
import Html.Events as Events
import Mouse
import Keyboard
import Debug
import String
import Char

type alias Model =
  { chars: String, count: Int }

type Action
  = NoOp
  | MouseClick Int
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
        [ Events.onClick address (MouseClick 1) ]
        [ Html.text "Click"]
    ]

update : Action -> Model -> Model
update action model =
  case action of
    MouseClick amount ->
      { model | count = model.count + amount}
    KeyPress key ->
      Debug.log (toString key)
      { model | chars = String.concat [model.chars, String.fromChar (Char.fromCode key)]}
    NoOp -> model

mouseClickSignal : Signal.Signal Action
mouseClickSignal = Signal.map (\_ -> MouseClick 2) Mouse.clicks

keyPressSignal : Signal.Signal Action
keyPressSignal = Signal.map (\key -> KeyPress key) Keyboard.presses

actionSignal : Signal.Signal Action
actionSignal = Signal.merge mb.signal keyPressSignal

mb : Signal.Mailbox Action
mb = Signal.mailbox NoOp



modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp
    update
    initialModel
    actionSignal

main : Signal.Signal Html

main = Signal.map (view mb.address) modelSignal
