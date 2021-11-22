let
    ihp = builtins.fetchGit {
        url = "https://github.com/digitallyinduced/ihp.git";
        ref = "refs/tags/v0.16.0";
    };
    node-env = import ./nodeenv.nix {};
    haskellEnv = import "${ihp}/NixSupport/default.nix" {
        ihp = ihp;
        optimized = true;
        haskellDeps = p: with p; [
            cabal-install
            base
            wai
            text
            hlint
            p.ihp
            load-env
        ];
        otherDeps = p: with p; [
            # Native dependencies, e.g. imagemagick
            nodejs
            entr
            node-env.nodeDependencies
        ];
        projectPath = ./.;
    };
in
    haskellEnv
