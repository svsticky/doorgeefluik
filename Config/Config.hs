module Config where

import IHP.Prelude
import IHP.Environment
import IHP.FrameworkConfig
import IHP.View.CSSFramework

config :: ConfigBuilder
config = do
    option Production
    option (AppHostname "localhost:1515")
    option tailwind


