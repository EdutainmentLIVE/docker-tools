#! /usr/bin/env sh
set -o errexit
checkout
mkdir --parents output/bin output/lib
docker run --interactive --rm --tty --volume "$PWD:$PWD" --workdir "$PWD" itprotv/stack:v2.5.1 stack --local-bin-path output/bin build --copy-bins apply-refact brittany hasktags hlint stan stylish-haskell weeder
strip output/bin/*
d='/root/.stack/programs/x86_64-linux/ghc-tinfo6-8.10.3/lib/ghc-8.10.3'
docker run --interactive --rm --tty --volume "$PWD:$PWD" --workdir "$PWD" itprotv/stack:v2.5.1 cp --recursive --target-directory output/lib --verbose "$d/llvm-passes" "$d/llvm-targets" "$d/package.conf.d" "$d/platformConstants" "$d/settings"
artifact push workflow output --expire-in 1w
