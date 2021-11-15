module Web.Controller.Routes where

import Web.Controller.Prelude
import Web.View.Routes.Index

instance Controller RoutesController where
    action RoutesAction = defaultIndex >>= render

    action VisitRouteAction { path } = do
        route <- query @Route |> filterWhere (#path, path) |> fetchOne
        redirectToUrl (get #url route)

    action EditRouteAction { routeId } = do
        routes <- query @Route |> fetch
        editId <- Just . get #id <$> fetch routeId
        let newRoute = newRecord @Route
        render IndexView { .. }

    action UpdateRouteAction { routeId } = do
        route <- fetch routeId
        route
            |> buildRoute
            >>= ifValid \case
                Left route -> defaultIndex >>= render
                Right route -> do
                    route <- route |> updateRecord
                    setSuccessMessage "Route updated"
                    redirectTo RoutesAction

    action CreateRouteAction = do
        let route = newRecord @Route
        route
            |> buildRoute
            >>= ifValid \case
                Left route -> do
                    view <- defaultIndex 
                    render (view { newRoute = route })
                Right route -> do
                    route <- route |> createRecord
                    setSuccessMessage "Route created"
                    redirectTo RoutesAction

    action DeleteRouteAction { routeId } = do
        route <- fetch routeId
        deleteRecord route
        setSuccessMessage "Route deleted"
        redirectTo RoutesAction

defaultIndex :: (?modelContext :: ModelContext) => _
defaultIndex = do
    routes <- query @Route |> fetch
    let newRoute = newRecord
    let editId = Nothing
    return IndexView { .. }

buildRoute route = route
    |> fill @'["url"]
    |> fill @'["path"]
    |> validateField #url nonEmpty
    |> validateField #url isUrl
    |> validateField #path nonEmpty
    |> validateIsUnique #path
