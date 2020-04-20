#!/usr/bin/env bash

suts=$BATS_TEST_DIRNAME

setup() {
    init
}

teardown() {
    rm -rf $suts/temp
}

function p {
    bash "$(dirname $BATS_TEST_DIRNAME)"/libexec/p "$@"
}

function init {
    touch $suts/temp
    echo "use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
  pod 'Typhoon', '~>4.0’
  # Analytics
end" > $suts/temp
}