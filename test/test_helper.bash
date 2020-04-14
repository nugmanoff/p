#!/usr/bin/env bash

suts=$BATS_TEST_DIRNAME/suts

function p {
    bash "$(dirname $BATS_TEST_DIRNAME)"/libexec/p "$@"
}

function init {
    touch $suts/temp
    echo "use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Altel' do
  pod 'R.swift'
  pod 'SwiftFormat/CLI'
end

def insert_pods
  pod 'Typhoon', '~>4.0’
  # Analytics
end" > $suts/temp
}