module Web.View.Routes.New where
import Web.View.Prelude

data NewView = NewView { route :: Route }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Route</h1>
        {renderForm route}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Routes" RoutesAction
                , breadcrumbText "New Route"
                ]

renderForm :: Route -> Html
renderForm route = formFor route [hsx|
    {(textField #url)}
    {submitButton}

|]
