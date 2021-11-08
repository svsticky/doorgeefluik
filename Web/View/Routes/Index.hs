module Web.View.Routes.Index where
import Web.View.Prelude

data IndexView = IndexView { routes :: [ Route ], newRoute :: Route, editId :: Maybe (Id Route)  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <div class="grid grid-cols-9 p-20 table">
        <h1 class="col-span-9">Doorgeefluiken</h1>
        <div class="col-span-3"><b>svsticky.nl/...</b></div>
        <div class="col-span-3"><b>url</b></div>
        <div class="col-span-1"></div>
        <div class="col-span-1"></div>
        <div class="col-span-1"></div>
        {forEach routes (renderLoop editId)}
        {if (isNothing editId) then renderForm newRoute else ""}
        </div>

    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Routes" RoutesAction
                ]

renderLoop :: Maybe (Id Route) -> Route -> Html
renderLoop Nothing route = renderRoute route
renderLoop (Just id) route = if id == get #id route then renderRouteEditable route else renderRoute route

renderRouteEditable :: Route -> Html
renderRouteEditable = renderForm

renderRoute :: Route -> Html
renderRoute route = [hsx|
    <div class="col-span-3"><p class="pd-2">{get #path route}</p></div>
    <div class="col-span-3">{get #url route}</div>
    <div class="col-span-1"><a href={VisitRouteAction (get #path route)}>Visit</a></div>
    <div class="col-span-1"><a href={EditRouteAction (get #id route)} class="text-muted">Edit</a></div>
    <div class="col-span-1"><a href={DeleteRouteAction (get #id route)} class="js-delete text-muted">Delete</a></div>
|]

renderForm :: Route -> Html
renderForm route = [hsx| <div class="col-span-9">{content}</div>|]
    where content = formFor route [hsx|
    <div class="grid grid-cols-9">
        <div class="col-span-3">{(textField #path) { fieldLabel = ""}}</div>
        <div class="col-span-3">{(textField #url) { fieldLabel = ""}}</div>
        <div class="col-span-3">{submitButton}</div>
    </div>
|]
