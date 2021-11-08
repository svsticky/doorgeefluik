module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Routes
import Web.Controller.Static

instance FrontController WebApplication where
    controllers = 
        [ startPage RoutesAction
        -- Generator Marker
        , parseRoute @RoutesController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
