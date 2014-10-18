fs = require('fs')
request = require('request')

rs = require('./restaurants.json')

requestLoop = (index=0, offset=0) ->
  return unless index < rs.length
  r = rs[index]
  if offset > r.review_count
    requestLoop(index + 1)
    return
  url = "#{r.url}?sort_by=date_asc&start=#{offset}"
  request(url).pipe(fs.createWriteStream("html/#{r.id}-#{offset}.html"))
  setTimeout((-> requestLoop(index, offset + 40)), 3)
  console.log("index: #{index}, offset: #{offset}")

requestLoop(387, 2000)
