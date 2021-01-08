#! /usr/bin/env sh
set -o errexit -o xtrace
exec docker run \
  --env "STACK_ROOT=$PWD/.stack/root" \
  --env "STACK_WORK=.stack/work" \
  --interactive \
  --rm \
  --tty \
  --volume "$PWD:$PWD" \
  --workdir "$PWD" \
  itprotv/stack:v2.5.1 \
  stack --allow-different-user --color never --jobs 2 --no-terminal "$@"
