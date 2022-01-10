#!/usr/bin/env run-script
module Application.Script.SeedDatabase where

import Application.Script.Prelude
import Control.Monad (void)

run :: Script
run = do
    route <- query @Route |> filterWhere (#path, "panda") |> fetchOneOrNothing

    case route of
        Just _ -> putStrLn "A recycled panda was already in place, disregard"
        Nothing -> do
            let route :: Route = newRecord { path = "panda", url = "https://www.youtube.com/watch?v=o-YBDTqX_ZU"}
            void $ createRecord route


