module Models (..) where

import Players.Models exposing (Player)
import Routing

type alias AppModel =
  { players : List Player
  , routing : Routing.Model
  }

initialModel : AppModel
initialModel =
  { players = [ Player 1 "Mirki" 1, Player 2 "Petki" 2 ]
  , routing = Routing.initialModel
  }
