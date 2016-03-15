module Main (..) where

import Html exposing (Html)
import Html.Events as Events
import Debug
import StartApp.Simple

import IncWidget as Widget

type alias AppModel =
  { widgetModel : Widget.Model }

type Action
  = WidgetAction Widget.Action
  | NoOp

initialModel : AppModel
initialModel = { widgetModel = Widget.initialModel}

view : Signal.Address Action -> AppModel -> Html
view address model =
  Html.div
    []
    [ Widget.view (Signal.forwardTo address WidgetAction) model.widgetModel ]

update : Action -> AppModel -> AppModel
update action model =
  case action of
    WidgetAction subAction ->
      let
        updatedWidgetModel = Widget.update subAction model.widgetModel
      in
        { model | widgetModel = updatedWidgetModel }
    _ -> model

main : Signal.Signal Html

main =
  StartApp.Simple.start
    { model = initialModel
    , view = view
    , update = update
    }
