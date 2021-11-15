module Web.Types where

import IHP.Prelude
import IHP.RouterPrelude hiding (tshow, error)
import IHP.ModelSupport
import Generated.Types
import Data.UUID

data WebApplication = WebApplication deriving (Eq, Show)
data StaticController = WelcomeAction deriving (Eq, Show, Data)

data RoutesController
    = RoutesAction
    | VisitRouteAction { path :: !Text }
    | CreateRouteAction
    | EditRouteAction { routeId :: !(Id Route) }
    | UpdateRouteAction { routeId :: !(Id Route) }
    | DeleteRouteAction { routeId :: !(Id Route) }
    deriving (Eq, Show, Data)

class Parsable a where
    getParser :: Parser a

instance Parsable Text where 
    getParser = remainingText

instance Parsable UUID where
    getParser = parseUUID

instance (KnownSymbol table, Parsable (PrimaryKey table)) => Parsable (Id' table) where
    getParser = Id <$> getParser

class ParseUrl a b where
    parseUrl' :: a -> Parser b

instance Parsable a => ParseUrl (a -> b) b where
    parseUrl' f =  f <$ string "/" <*> getParser

instance ParseUrl a a where
    parseUrl' x = pure x

parseAction s f = string "/" >> string s >> parseUrl' f

instance CanRoute RoutesController where
    parseRoute' = parseAction "edit" EditRouteAction
              <|> parseAction "visit" VisitRouteAction
              <|> parseAction "delete" DeleteRouteAction
              <|> parseAction "create" CreateRouteAction
              <|> parseAction "update" UpdateRouteAction
              <|> parseAction "" RoutesAction

instance HasPath RoutesController where
    pathTo RoutesAction = "/"
    pathTo (VisitRouteAction path) = "/visit/" <> path
    pathTo (EditRouteAction id) = "/edit/" <> tshow id
    pathTo (DeleteRouteAction id) = "/delete/" <> tshow id
    pathTo (UpdateRouteAction id) = "/update/" <> tshow id
    pathTo CreateRouteAction = "/create"
