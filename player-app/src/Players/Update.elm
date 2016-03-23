module Players.Update (..) where

import Effects exposing (Effects)
import Hop.Navigate exposing (navigateTo)

import Players.Actions exposing (..)
import Players.Models exposing (..)

type alias UpdateModel =
  { players : List Player
  }

update : Action -> UpdateModel -> ( List Player, Effects Action )
update action model =
  case action of
    EditPlayer id ->
      let
        path = "/players/" ++ (toString id) ++ "/edit"
      in
        ( model.players, Effects.map HopAction (navigateTo path) )
    ListPlayers ->
      let path = "/players"
      in ( model.players, Effects.map HopAction (navigateTo path) )
    FetchAllDone result ->
      case result of
        Ok players ->
          ( players, Effects.none )
        Err error ->
          ( model.players, Effects.none )

    HopAction _ ->
      ( model.players, Effects.none )
    NoOp ->
      ( model.players, Effects.none )
