module Update (..) where
import Effects exposing (Effects)

import Models exposing (..)
import Actions exposing (..)

update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  ( model, Effects.none )
