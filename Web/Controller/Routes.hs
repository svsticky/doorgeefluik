module Web.Controller.Routes where

import Web.Controller.Prelude
import Web.View.Routes.Index
import Web.View.Routes.New
import Web.View.Routes.Edit
import Web.View.Routes.Show

instance Controller RoutesController where
    action RoutesAction = do
        routes <- query @Route |> fetch
        let newRoute = newRecord
        let editId = Nothing
        render IndexView { .. }

    action NewRouteAction = do
        let route = newRecord
        render NewView { .. }

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
            |> ifValid \case
                Left route -> render EditView { .. }
                Right route -> do
                    route <- route |> updateRecord
                    setSuccessMessage "Route updated"
                    redirectTo RoutesAction

    action CreateRouteAction = do
        let route = newRecord @Route
        route
            |> buildRoute
            |> ifValid \case
                Left route -> do
                    routes <- query @Route |> fetch
                    let newRoute = route
                    let editId = Nothing
                    render IndexView { .. } 
                Right route -> do
                    route <- route |> createRecord
                    setSuccessMessage "Route created"
                    redirectTo RoutesAction

    action DeleteRouteAction { routeId } = do
        route <- fetch routeId
        deleteRecord route
        setSuccessMessage "Route deleted"
        redirectTo RoutesAction

buildRoute route = route
    |> fill @'["url"]
    |> fill @'["path"]
    |> validateField #url nonEmpty
    |> validateField #url isUrl
    |> validateField #path nonEmpty
