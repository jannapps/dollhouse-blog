{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    ruby_3_2
    nodejs
    yarn
    sqlite
    libffi
    openssl
    zlib
    readline
    libyaml
    git
  ];

  shellHook = ''
    export GEM_HOME="$PWD/.gems"
    export GEM_PATH="$GEM_HOME"
    export PATH="$GEM_HOME/bin:$PATH"
    export BUNDLE_PATH="$GEM_HOME"
    
    # Install specific bundler version compatible with Ruby 3.2
    if [ ! -f "$GEM_HOME/bin/bundler" ]; then
      echo "Installing Bundler 2.5.6..."
      gem install bundler:2.5.6
    fi
    
    echo "Ruby on Rails development environment loaded!"
    echo "Ruby version: $(ruby --version)"
    echo "Bundler version: $(bundler --version)"
  '';
}