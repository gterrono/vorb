var key = 'cip_PAXK6OHCswuz5iM2ow'
  , c_secret = '-ZubTn55hzin1pO0FluEyZZJt7A'
  , token = 'PV6WOm0iHIx0hHC8_FySWUtXyBJNdFFS'
  , t_secret = 'Y_3uRFFdyhAhDWt2_EgSSK-L2O8'

var yelp = require("yelp").createClient({
  consumer_key: key,
  consumer_secret: c_secret,
  token: token,
  token_secret: t_secret,
  ssl: true
});

var restaurants = []

var callback = function(error, data) {
  console.log(error);
  console.log(data);
});

yelp.search({term: "food", location: "Montreal"},
yelp.business("yelp-san-francisco", function(error, data) {
  console.log(error);
  console.log(data);
});

