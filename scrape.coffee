# data = require("./restaurants")

# jsdom = require('jsdom')
# jsdom.env(
#   url: "http://www.yelp.com/biz/tortilleria-san-roman-philadelphia"
#   scripts: ['http://code.jquery.com/jquery-1.5.min.js']
#   done: (err, window) ->
#     $ = window.jQuery
#     console.log($(".review"))
# )

_ = require('underscore')
fs = require('fs')

request = require('request')
url = "http://www.yelp.com/biz/tortilleria-san-roman-philadelphia"
request(url).pipe(fs.createWriteStream("pages/req.html"))
