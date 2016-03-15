module IncWidget where

import Html exposing (Html)
import Html.Events as Events

type alias Model = { count: Int }

initialModel = { count = 0 }

type Action = Increase
  | NoOp

view : Signal.Address Action -> Model -> Html
view address model =
  Html.div
    []
    [ Html.div
      []
      [ Html.text (toString model.count) ]
    , Html.button
        [ Events.onClick address Increase ]
        [ Html.text "Click" ]
    ]

update : Action -> Model -> Model
update action model =
  case action of
    Increase -> { model | count = model.count + 1 }
    _ -> model
