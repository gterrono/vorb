_ = require('underscore')
fs = require('fs')

html = fs.readFileSync("req.html").toString()

jsdom = require('jsdom')

reviews = []
jsdom.env(
  html: html
  scripts: ['http://code.jquery.com/jquery-1.5.min.js']
  done: (err, window) ->
    $ = window.jQuery
    $(".review").each (index, el) ->
      elem = $(el)
      review = {}
      # review['name'] = elem.find(".user-display-name").text()
      review['date'] = elem.find(".rating-qualifier meta").attr("content")
      review['rating'] = parseInt(elem.find(".biz-rating meta").attr("content"),10)
      # review['comment'] = elem.find(".review_comment").text()
      console.log(review)
      reviews.push(review)
)

console.log(reviews)
