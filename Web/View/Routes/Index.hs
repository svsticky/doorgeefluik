module Web.View.Routes.Index where
import Web.View.Prelude

data IndexView = IndexView { routes :: [ Route ], newRoute :: Route, editId :: Maybe (Id Route)  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <h1>Doorgeefluiken</h1>
        <div class="container">
        <div class="row">
            <div class="col-3"><b>svsticky.nl/...</b></div>
            <div class="col-3"><b>url</b></div>
            <div class="col-2"></div>
            <div class="col-2"></div>
            <div class="col-2"></div>
        </div>
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
    <div class="row">
        <div class="col-3 pd-2"><p class="pd-2">{get #path route}</p></div>
        <div class="col-3">{get #url route}</div>
        <div class="col-2"><a href={VisitRouteAction (get #path route)}>Visit</a></div>
        <div class="col-2"><a href={EditRouteAction (get #id route)} class="text-muted">Edit</a></div>
        <div class="col-2"><a href={DeleteRouteAction (get #id route)} class="js-delete text-muted">Delete</a></div>
    </div>
|]

renderForm :: Route -> Html
renderForm route = formFor route [hsx|
    <div class="row">
        <div class="col-4">{(textField #path) { fieldLabel = ""}}</div>
        <div class="col-4">{(textField #url) { fieldLabel = ""}}</div>
        <div class="col-2">{submitButton}</div>
        <div class="col-2"></div>
        <div class="col-2"></div>
    </div>
|]
