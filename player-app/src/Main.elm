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
    , inputs = [ routerSignal ]
    }

routerSignal : Signal Action
routerSignal =
  Signal.map RoutingAction Routing.signal


main : Signal.Signal Html
main = app.html

port runner : Signal (Task.Task Never ())
port runner =
  app.tasks

port routeRunTask : Task.Task () ()
port routeRunTask =
  Routing.run
