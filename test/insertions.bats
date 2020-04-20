load test_helper

@test "insertion into target" {
    result="$(p -a Alamofire -t Croco -f $suts/temp -d)"
    text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'Alamofire'
  pod 'R.swift'
end

def insert_pods
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
    [ "$result" == "$text" ]
}

@test "insertion into: 1) def group" {
   result="$(p -a Alamofire -g insert_pods -f $suts/temp -d)"
   text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
pod 'Alamofire'
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
    [ "$result" == "$text" ]
}

@test "insertion into: 2) comment group" {
   result="$(p -a Alamofire -g Analytics -f $suts/temp -d)"
   text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
  pod 'Typhoon', '~>4.0’
  # Analytics
  pod 'Alamofire'
end"
    [ "$result" == "$text" ]
}

@test "insertion into root" {
  result="$(p -a Alamofire -p "root" -f $suts/temp -d)"
  text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!
pod 'Alamofire'

target 'Croco' do
  pod 'R.swift'
end

def insert_pods
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
[ "$result" == "$text" ]
}