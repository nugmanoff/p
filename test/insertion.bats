dir="$(dirname "$BATS_TEST_DIRNAME")"

@test "insertion into target" {
    result="$(bash $dir/libexec/p -a Alamofire -t Altel -f $BATS_TEST_DIRNAME/podfile-altel -d)"
    text="target 'Altel' do
pod 'Alamofire'
end"
    [ "$result" == "$text" ]
}

@test "insertion into: 1) def group" {  
   result="$(bash $dir/libexec/p -a Alamofire -g insert_pods -f $BATS_TEST_DIRNAME/podfile-gleam -d)"
   text="def insert_pods
pod 'Alamofire'
end"
    [ "$result" = "$text" ]
}

@test "insertion into: 2) # comment group" {
  result="$(bash $dir/libexec/p -a Alamofire -p "1.0" -f $BATS_TEST_DIRNAME/podfile-population)"
  text="def my_pods
  # Fabric
  pod 'Fabric', '1.7.3'
  pod 'Crashlytics', '3.10.0'
  
# Request
pod 'Alamofire', '1.0'
end"
    #[ "$result" = "$text" ]
}