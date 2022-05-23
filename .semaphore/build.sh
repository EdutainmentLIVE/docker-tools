#! /usr/bin/env sh
set -o errexit
checkout
cache restore stack
mkdir --parents .stack/root .stack/work output/bin output/lib
./stack.sh --local-bin-path output/bin build --copy-bins apply-refact-0.9.3.0 brittany-0.14.0.2 hlint-3.3.6 weeder-2.3.1
cache store stack .stack
strip output/bin/*
./stack.sh exec -- sh -c 'target="$PWD/output/lib" && cd "$STACK_ROOT/programs/x86_64-linux/ghc-tinfo6-9.0.2/lib/ghc-9.0.2" && cp --recursive --target-directory "$target" --verbose llvm-passes llvm-targets package.conf.d platformConstants settings'
artifact push workflow output --expire-in 1w
