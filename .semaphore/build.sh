#! /usr/bin/env sh
set -o errexit
checkout
cache restore stack
mkdir --parents .stack/root .stack/work output/bin output/lib
./stack.sh --local-bin-path output/bin build --copy-bins apply-refact brittany hasktags hlint stan stylish-haskell weeder
cache store stack .stack
strip output/bin/*
./stack.sh exec -- sh -o xtrace -c 'target="$PWD/output/lib" && cd "$STACK_ROOT/programs/x86_64-linux/ghc-tinfo6-8.10.3/lib/ghc-8.10.3" && cp --recursive --target-directory "$target" --verbose llvm-passes llvm-targets package.conf.d platformConstants settings'
artifact push workflow output --expire-in 1w
