fs = require('fs')
request = require('request')

rs = require('./restaurants.json')

requestLoop = (index=0, offset=0) ->
  return unless index < rs.length
  r = rs[index]
  if offset > r.review_count
    requestLoop(index + 1)
    return
  file_path = "html/#{r.id}-#{offset}.html"
  size = fs.statSync(file_path).size
  if size == 0
    url = "#{r.url}?sort_by=date_asc&start=#{offset}"
    request(url).pipe(fs.createWriteStream(file_path))
    console.log("index: #{index}, offset: #{offset}")
  setTimeout((-> requestLoop(index, offset + 40)), 3)

requestLoop()
