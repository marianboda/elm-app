module Players.Actions (..) where
import Hop
import Http

import Players.Models exposing (PlayerId, Player)

type Action
  = NoOp
  | HopAction ()
  | EditPlayer PlayerId
  | ListPlayers
  | FetchAllDone (Result Http.Error (List Player))
