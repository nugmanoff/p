load test_helper

@test "insertion into target" {
    result="$(p -a Alamofire -t Altel -f $suts/podfile-altel -d)"
    text="target 'Altel' do
pod 'Alamofire'
end"
    [ "$result" == "$text" ]
}

@test "insertion into: 1) def group" {  
   result="$(p -a Alamofire -g insert_pods -f $suts/podfile-gleam -d)"
   text="def insert_pods
pod 'Alamofire'
end"
    [ "$result" = "$text" ]
}

@test "insertion into: 2) # comment group" {
  result="$(p -a Alamofire -g Request -f $suts/podfile-population)"
  text="def my_pods
  # Fabric
  pod 'Fabric', '1.7.3'
  pod 'Crashlytics', '3.10.0'
  
# Request
pod 'Alamofire'
end"
    [ "$result" = "$text" ]
}