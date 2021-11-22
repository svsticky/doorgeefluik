module Main where
import IHP.Prelude

import Config
import qualified IHP.Server
import IHP.RouterSupport
import IHP.FrameworkConfig
import IHP.Job.Types
import Web.FrontController
import Web.Types
import LoadEnv

instance FrontController RootApplication where
    controllers = [
            mountFrontController WebApplication
        ]

instance Worker RootApplication where
    workers _ = []

main :: IO ()
main = loadEnv >> IHP.Server.run config
