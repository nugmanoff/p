dir="$(dirname "$BATS_TEST_DIRNAME")"

@test "insertion target" {
    result="$(bash $dir/libexec/p -a Alamofire -t Altel -f $BATS_TEST_DIRNAME/podfile-altel -d)"
    text="use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'Altel' do
pod 'Alamofire'
  pod 'R.swift'
  pod 'Sourcery'
  pod 'SwiftFormat/CLI'
  pod 'SwiftLint'
end"
    [ "$result" == "$text" ]
}

@test "insertion def" {
   result="$(bash $dir/libexec/p -a Alamofire -g insert_pods -f $BATS_TEST_DIRNAME/podfile-gleam -d)"
   text="def insert_pods
pod 'Alamofire'
  pod 'Typhoon', '~>4.0’
  pod 'NVActivityIndicatorView', '~>4.4'
  pod 'SnapKit', '~>4.2'
  pod 'RxSwift', '~>4.2'
  pod 'DTCollectionViewManager', '~> 6.4'
  pod 'HCSStarRatingView', '~> 1.5'
  pod 'Moya', '~> 11.0'
end

target 'Gleam' do
  use_frameworks!
  # Pods for Gleam
  insert_pods
end"
    [ "$result" == "$text" ]
}
