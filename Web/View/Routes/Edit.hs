module Web.View.Routes.Edit where
import Web.View.Prelude

newtype EditView = EditView { route :: Route }

instance View EditView where
    html EditView { .. } = [hsx|
        <h1>Edit Route</h1>
        {renderForm route}
    |]

renderForm :: Route -> Html
renderForm route = formFor route [hsx|
    {(textField #path)}
    {(textField #url)}
    {submitButton}
|]
