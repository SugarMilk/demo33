# How To Use

```ruby

source 'http://gitlab.bojoy.net:9090/SDK_iOS_GameFriend/GameFriendSDKSpecs.git'
source 'http://gitlab.bojoy.net:9090/SDK_iOS_Common/GFSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'

target 'targetName' do

    pod 'GFPersistence'

end

```

```ruby
Dependencies:

GFPersistenceConfig
GFKeychain

JSONKit
XMLDictionary

```

```ruby

pod repo add XXSpecs http://...

pod repo update XXSpecs

pod cache clean XXRepository

pod cache clean --all

```