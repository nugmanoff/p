#!/usr/bin/env bash

suts=$BATS_TEST_DIRNAME/suts

function p {
    bash "$(dirname $BATS_TEST_DIRNAME)"/libexec/p "$@"
}
