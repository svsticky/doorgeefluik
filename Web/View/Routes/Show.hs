module Web.View.Routes.Show where
import Web.View.Prelude

data ShowView = ShowView { route :: Route }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Route</h1>
        <p>{route}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Routes" RoutesAction
                            , breadcrumbText "Show Route"
                            ]