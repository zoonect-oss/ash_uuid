{
  description = "zoonect-oss/ash_uuid";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-unstable.url = github:nixos/nixpkgs/nixpkgs-unstable;
    rust-overlay.url = "github:oxalica/rust-overlay";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs-unstable, rust-overlay, flake-utils, ... } @ args: flake-utils.lib.eachSystem ["aarch64-darwin" "x86_64-darwin" "x86_64-linux"] (system: let
    overlays = [ (import rust-overlay) ];
    pkgs = import nixpkgs-unstable { inherit system overlays; };

    # erlangVersion = "erlang_26";
    # erlang = pkgs.beam.interpreters.${erlangVersion};

    # elixirVersion = "elixir_1_15";
    # elixir = pkgs.beam.packages.${erlangVersion}.${elixirVersion};

    rustVersion = "1.70.0";
    rust = pkgs.rust-bin.stable.${rustVersion}.default;

    inherit (pkgs.lib) optional optionals;

    fileWatchers = with pkgs; (
      optional stdenv.isLinux [libnotify inotify-tools] ++
      optional stdenv.isDarwin [terminal-notifier] ++ (with darwin.apple_sdk.frameworks; [CoreFoundation CoreServices])
    );
  in rec {
    devShells.default = nixpkgs-unstable.legacyPackages.${system}.mkShell {
      buildInputs = [
        # erlang
        # elixir
        rust
      ]
      ++ (with pkgs; [
        postgresql_15
      ])
      ++ fileWatchers;

      shellHook = ''
        export HEX_HOME="$PWD/.nix/hex"
        mkdir -p $HEX_HOME
        export MIX_HOME="$PWD/.nix/mix"
        mkdir -p $MIX_HOME
        export DATA_POSTGRES="$PWD/.data/postgres"
        mkdir -p $DATA_POSTGRES

        export PATH="$MIX_HOME/bin:$MIX_HOME/escripts:$HEX_HOME/bin:$PATH"
        export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$PWD/.nix/history\"'"
        export PGDATA=$DATA_POSTGRES
        export OVERMIND_PROCFILE="$PWD/.overmind.yml"
        export OVERMIND_SOCKET="$PWD/.ops/.overmind.sock"
        export OVERMIND_CAN_DIE=app

        mix local.rebar --if-missing --force
        mix local.hex --if-missing --force
      '';
    };
  });
}
