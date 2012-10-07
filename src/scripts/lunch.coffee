# Description
#   Returns a random Boulder restaurant.
#
# Dependencies:
#   'yelp': '0.1.1'
#
# Commands:
#   hubot [random|search_term] [food|lunch|restaurant] [at|in|near|by|around|close to] [location]

yelp = require('yelp').createClient(
  consumer_key: process.env.YELP_CONSUMER_KEY
  consumer_secret: process.env.YELP_CONSUMER_SECRET
  token: process.env.YELP_TOKEN
  token_secret: process.env.YELP_TOKEN_SECRET
)

module.exports = (robot) ->
  robot.respond /where (do you think|should) (we|i)? (eat|have lunch|munch)/i, (msg) ->

module.exports = (robot) ->
  robot.respond /(.+) (food|restaurant) (at|in|near|by|around|close to) (.*)/i, (msg) ->
    filter = msg[1]

    if filter == 'random'
      filter = 'bagels,bakeries,breweries,desserts,foodtrucks,gourmet,streetvendors,restaurants'

    query =
      term: ''
      category_filter: filter
      location: msg.match[4]

    yelp.search query, (error, data)->
      unless error
        if data.businesses.length > 0
          bsns = data.businesses[Math.floor(Math.random() * data.businesses.length) - 1]

          msg.send "#{business.name} at #{business.location.address} (rated: #{business.rating}/5 by #{business.review_count}}people.)"
          msg.send business.url
