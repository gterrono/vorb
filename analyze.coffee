_ = require('underscore')
fs = require('fs')

numDaysOpen = (date) ->
  (new Date().getTime() - Date.parse(date)) / 1000 / 3600 / 24

recent_cutoff_date = '2012-1-1'
recentDaysOpen = (r) ->
  Math.min(r.num_days_open, numDaysOpen(recent_cutoff_date))

computeVORB = (r) ->
  (r.avg_rating-3.3) * Math.log(r.review_count) *
    (r.recent_review_count / recentDaysOpen(r))

api_data = {}
for restaurant in require('./restaurants.json')
  api_data[restaurant.id] = restaurant

data = []
for id, ratings of require("./ratings.json")
  restaurant =
    id: id
    name: api_data[id].name
    url: api_data[id].url
    review_count: ratings.length
    recent_review_count: _.filter(ratings,
      (r) -> Date.parse(r.date) > Date.parse(recent_cutoff_date)).length
    open_date: _.sortBy(ratings, (r) -> Date.parse(r.date))[0].date
    avg_rating: _.reduce(ratings, ((sum, r) -> r.rating + sum), 0)/ratings.length
  restaurant.num_days_open = numDaysOpen(restaurant.open_date)
  restaurant.vorb = computeVORB(restaurant)
  data.push(restaurant)

fs.writeFile "formatted_data.json", JSON.stringify(data), (err) ->
  console.log(err) if err?

for restaurant in _.sortBy(data, (r) -> -r.vorb).slice(0,10)
  console.log(restaurant)
