module Main (..) where

import Html exposing (..)
import Effects exposing ( Effects, Never )
import Task
import StartApp

import Actions exposing ( Action )
import Models exposing (..)

import Update exposing (..)
import View exposing (..)

init : ( AppModel, Effects Action )
init = ( initialModel, Effects.none )

app : StartApp.App AppModel
app =
  StartApp.start
    { init = init
    , view = view
    , update = update
    , inputs = []
    }

main : Signal.Signal Html
main = app.html

port runner : Signal (Task.Task Never ())
port runner =
  app.tasks
