_ = require('underscore')
fs = require('fs')

data = {}
for name, ratings of require("./ratings.json")
  data[name] =
    review_count: ratings.length
    open_date: ratings[0].date
    avg_rating: _.reduce(ratings, ((sum, r) -> r.rating + sum), 0)/ratings.length

fs.writeFile "formatted_data.json", JSON.stringify(data), (err) ->
  console.log(err) if err?

