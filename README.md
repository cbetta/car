# My car API

Currently the app just pulls in data from my [Drive2Improve](https://drivetoimprove.co.uk/) profile and shows the current location on the map. I am not going to share much more because it is not using any official API.

The most [interesting code](https://github.com/cbetta/car/blob/master/app/models/user.rb) (in my eyes) is the authorisation. The app uses Facebook for login but authorises users against a friends list controlled by me. This means only family and friends that I authorized can see the map.

