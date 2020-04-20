load test_helper

@test "skipping reserved word" {
  # checking skipping reserved word after all insertions
  result="$(p -a Alamofire -p 'root' -f $suts/temp)"
  result="$(p -a Alamofire -t Croco -f $suts/temp)"
  result="$(p -a Alamofire -g insert_pods -f $suts/temp -d)"

  text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!
pod 'Alamofire'

target 'Croco' do
  pod 'Alamofire'
  pod 'R.swift'
end

def insert_pods
pod 'Alamofire'
  pod 'Typhoon', '~>4.0’
  # Analytics
end"
   
   [ "$result" = "$text" ]  
}