module Main (..) where

import Html exposing (..)
import Effects exposing ( Effects, Never )
import Task
import StartApp

import Routing
import Actions exposing (..)
import Models exposing (..)
import Update exposing (..)
import View exposing (..)
import Players.Effects
import Players.Actions
import Mailboxes exposing (..)

init : ( AppModel, Effects Action )
init =
  let
    fxs = [ Effects.map PlayersAction Players.Effects.fetchAll ]
    fx = Effects.batch fxs
  in
    ( initialModel, fx)

app : StartApp.App AppModel
app =
  StartApp.start
    { init = init
    , view = view
    , update = update
    , inputs = [ routerSignal, actionsMailbox.signal, getDeleteConfirmationSignal ]
    }

routerSignal : Signal Action
routerSignal =
  Signal.map RoutingAction Routing.signal

getDeleteConfirmationSignal : Signal Actions.Action
getDeleteConfirmationSignal =
  let
    toAction id = id
      |> Players.Actions.DeletePlayer
      |> PlayersAction
  in
    Signal.map toAction getDeleteConfirmation

main : Signal.Signal Html
main = app.html

port runner : Signal (Task.Task Never ())
port runner =
  app.tasks

port routeRunTask : Task.Task () ()
port routeRunTask =
  Routing.run

port askDeleteConfirmation : Signal ( Int, String )
port askDeleteConfirmation =
  askDeleteConfirmationMailbox.signal

port getDeleteConfirmation : Signal Int
