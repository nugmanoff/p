load test_helper

@test "insertion with options: 1) configurations" {
   result="$(p -a AFNetworking -o "configurations=['Debug', 'Beta']" -g insert_pods -f $suts/temp -d)"
   text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
pod 'AFNetworking', :configurations => ['Debug', 'Beta']
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
    [ "$result" == "$text" ]
}

@test "insertion with options: 1) subspecs" {
   result="$(p -a AFNetworking -o "subspecs=['Attribute', 'QuerySet']" -g insert_pods -f $suts/temp -d)"
   text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
pod 'AFNetworking', :subspecs => ['Attribute', 'QuerySet']
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
    [ "$result" == "$text" ]
}

@test "insertion with options: 2) modular headers" {
   result="$(p -a AFNetworking -o "modular_headers=true" -g insert_pods -f $suts/temp -d)"
   text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
pod 'AFNetworking', :modular_headers => true
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
    [ "$result" == "$text" ]
}

@test "insertion with options: 3) source" {
   result="$(p -a AFNetworking -o "source=https://github.com/CocoaPods/Specs.git" -g insert_pods -f $suts/temp -d)"
   text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
pod 'AFNetworking', :source => 'https://github.com/CocoaPods/Specs.git'
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
    [ "$result" == "$text" ]
}

@test "insertion with options: 4) subspecs" {
   result="$(p -a AFNetworking -o "subspecs=['Attribute', 'QuerySet']" -g insert_pods -f $suts/temp -d)"
   text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
pod 'AFNetworking', :subspecs => ['Attribute', 'QuerySet']
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
    [ "$result" == "$text" ]
}

@test "insertion with options: 5) testspecs" {
   result="$(p -a AFNetworking -o "testspecs=['UnitTests', 'SomeOtherTests']" -g insert_pods -f $suts/temp -d)"
   text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
pod 'AFNetworking', :testspecs => ['UnitTests', 'SomeOtherTests']
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
    [ "$result" == "$text" ]
}

@test "insertion with options: 6) using the files from a local path" {
   result="$(p -a AFNetworking -o "path=~/Documents/AFNetworking" -g insert_pods -f $suts/temp -d)"
   text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
pod 'AFNetworking', :path => '~/Documents/AFNetworking'
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
    [ "$result" == "$text" ]
}

@test "insertion with options: 7) from a podspec in the root of a library repository" {
   result="$(p -a AFNetworking -o "git=https://github.com/gowalla/AFNetworking.git;branch=dev" -g insert_pods -f $suts/temp -d)"
   text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :branch => 'dev'
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
    [ "$result" == "$text" ]
}