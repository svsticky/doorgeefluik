#!/usr/bin/env run-script
module Application.Script.SeedDatabase where

import Application.Script.Prelude

run :: Script
run = do
    let route :: Route = newRecord { path = "panda", url = "https://www.youtube.com/watch?v=o-YBDTqX_ZU"}
    route <- createRecord route
    pure ()

