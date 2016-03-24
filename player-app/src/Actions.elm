module Actions (..) where

import Routing
import Players.Actions


type Action
  = NoOp
  | PlayersAction Players.Actions.Action
  | RoutingAction Routing.Action
  | ShowError String
