module Main (..) where

import Html exposing (Html)
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

view : Model -> Html
view model = Html.text (toString model.count)

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
actionSignal = Signal.merge mouseClickSignal keyPressSignal

modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp
    update
    initialModel
    actionSignal

main : Signal.Signal Html

main = Signal.map view modelSignal
