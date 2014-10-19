_ = require('underscore')
fs = require('fs')
cheerio = require('cheerio')

parseRestaurant = (name) ->
  reviews = []
  for offset in [0...10000] by 40
    filename = "html/#{name}-#{offset}.html"
    if not fs.existsSync(filename)
      break
    parseFile(filename, reviews)
  reviews

parseFile = (filename, reviews) ->
  console.log(filename)
  html = fs.readFileSync(filename).toString()
  $ = cheerio.load(html)
  $(".review").each (index, el) ->
    elem = $(el)
    review = {}
    # review['name'] = elem.find(".user-display-name").text()
    review['date'] = elem.find(".rating-qualifier meta").attr("content")
    review['rating'] = parseInt(elem.find(".biz-rating meta").attr("content"),10)
    # review['comment'] = elem.find(".review_comment").text()
    reviews.push(review)

restaurants = require('./restaurants')
ratings = {}

for restaurant, index in restaurants
  name = restaurant.id
  console.log("#{index}: #{name}")
  ratings[name] = parseRestaurant(name)

fs.writeFile "ratings.json", JSON.stringify(ratings), (err) ->
  console.log(err) if err?

