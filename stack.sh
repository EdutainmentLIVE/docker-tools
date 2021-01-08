#! /usr/bin/env sh
set -o errexit -o xtrace
docker build --tag stack docker
exec docker run \
  --env "STACK_ROOT=$PWD/.stack/root" \
  --env "STACK_WORK=.stack/work" \
  --interactive \
  --rm \
  --tty \
  --volume "$PWD:$PWD" \
  --workdir "$PWD" \
  stack stack --allow-different-user --color never --jobs 2 --no-terminal "$@"
