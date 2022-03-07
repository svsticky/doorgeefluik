module Web.View.Routes.Index where
import Web.View.Prelude

data IndexView = IndexView { routes :: [ Route ], newRoute :: Route, editId :: Maybe (Id Route)  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <div class="grid grid-cols-8 p-20 table">
        <h1 class="col-span-9">Doorgeefluiken 🚪</h1>
        <div class="col-span-3"><b>svsticky.nl/...</b></div>
        <div class="col-span-3"><b>url</b></div>
        <div class="col-span-1"></div>
        <div class="col-span-1"></div>
        {forEach (filter isPoster routes) (renderLoop editId)}
        <div class="col-span-8"><hr/></div>
        {forEach (filter (not . isPoster) routes) (renderLoop editId)}
        {if (isNothing editId) then renderForm "create" newRoute else ""}
        </div>

    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Routes" RoutesAction
                ]

isPoster :: Route -> Bool
isPoster Route {..} = "poster" `isPrefixOf` path

renderLoop :: Maybe (Id Route) -> Route -> Html
renderLoop Nothing route = renderRoute route
renderLoop (Just id) route = if id == get #id route then renderRouteEditable route else renderRoute route

renderRouteEditable :: Route -> Html
renderRouteEditable r = renderForm ("/update/" <> tshow (get #id r)) r

renderRoute :: Route -> Html
renderRoute route = [hsx|
    <div class="col-span-3"><p class="pd-2">{get #path route}</p></div>
    <div class="col-span-3"><a target="blank" href={VisitRouteAction (get #path route)}>{get #url route}</a></div>
    <div class="col-span-1"><button class="btn bg-green-800"><a href={EditRouteAction (get #id route)} class="text-muted">Edit</a></button></div>
    <div class="col-span-1"><button class="btn bg-red-600"><a href={DeleteRouteAction (get #id route)} class="js-delete text-muted">Delete</a></button></div>
|]

renderForm :: Text -> Route -> Html
renderForm action route = [hsx| <div class="col-span-8">{content}</div>|]
    where content = formForWithOptions route (withAction action) [hsx|
    <div class="grid grid-cols-8">
        <div class="col-span-3">{(textField #path) { fieldLabel = "", disableValidationResult = True }}</div>
        <div class="col-span-3">{(textField #url) { fieldLabel = "", disableValidationResult = True }}</div>
        <div class="col-span-1">{submitButton}</div>
        <div class="col-span-1"></div>

        <div class="col-span-3 m-0">{validationResult #path}</div>
        <div class="col-span-3">{validationResult #url}</div>
    </div>
|]
