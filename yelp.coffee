key = 'cip_PAXK6OHCswuz5iM2ow'
c_secret = '-ZubTn55hzin1pO0FluEyZZJt7A'
token = 'PV6WOm0iHIx0hHC8_FySWUtXyBJNdFFS'
t_secret = 'Y_3uRFFdyhAhDWt2_EgSSK-L2O8'

yelp = require("yelp").createClient({
  consumer_key: key,
  consumer_secret: c_secret,
  token: token,
  token_secret: t_secret,
  ssl: true
})

_ = require('underscore')

fs = require('fs')

restaurants = []

callback = (error, data) ->
  console.log(error)
  for b in data.businesses
    restaurants.push b
  fs.writeFile 'restaurants.json', JSON.stringify(restaurants), (err) ->
    console.log(err) if err?
    console.log 'logged'

params = {category_filter: "restaurants", bounds: '39.979175377662955,-75.11377885937691|39.91337356024762,-75.22158220410347'}

yelp.search(params, callback)
