module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data RoutesController
    = RoutesAction
    | NewRouteAction
    | VisitRouteAction { path :: !Text }
    | CreateRouteAction
    | EditRouteAction { routeId :: !(Id Route) }
    | UpdateRouteAction { routeId :: !(Id Route) }
    | DeleteRouteAction { routeId :: !(Id Route) }
    deriving (Eq, Show, Data)
