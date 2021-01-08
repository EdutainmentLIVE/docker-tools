#! /usr/bin/env sh
set -o errexit
yum update -y && yum install -y lftp
checkout
cache restore hackage
cabal update
cache store hackage ~/.cabal
cabal freeze
cat cabal.project.freeze
hash=$( checksum cabal.project.freeze )
cache restore "cabal-$hash,cabal"
mkdir --parents output/bin output/lib
cabal install --installdir output/bin --install-method copy apply-refact brittany hasktags hlint stan stylish-haskell weeder
cache store "cabal-$hash" ~/.cabal/store
strip output/bin/*
cp --recursive --target-directory output/lib /opt/ghc/8.10.3/lib/ghc-8.10.3/llvm-passes /opt/ghc/8.10.3/lib/ghc-8.10.3/llvm-targets /opt/ghc/8.10.3/lib/ghc-8.10.3/package.conf.d /opt/ghc/8.10.3/lib/ghc-8.10.3/platformConstants /opt/ghc/8.10.3/lib/ghc-8.10.3/settings
artifact push workflow output --expire-in 1w
