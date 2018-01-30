# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'


  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BFIDemoPlayer

# ignore all warnings from all pods
inhibit_all_warnings!

def bfiDemoPlayer_pods
#    //inherit! :search_paths
    pod 'RxSwift',    '~> 3.0'
    pod 'Alamofire', '~> 4.2.0'
    pod 'RealmSwift', '~> 3.1'
end

target 'BFIDemoPlayer' do
    bfiDemoPlayer_pods
end

  target 'BFIDemoPlayerTests' do
#    inherit! :search_paths
    pod 'KIF', :configurations => ['Debug']
  end

  target 'BFIDemoPlayerUITests' do


  end


