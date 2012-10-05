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
  robot.respond /(.+) (food|lunch|restaurant) (at|in|near|by|around|close to) (.*)/i, (msg) ->
    food = msg[1]
    food = 'food' if food == 'random'

    search = { term: food, location: msg.match[4] }

    yelp.search search, (error, data)->
      unless error
        if data.businesses.length > 0
          business = data.businesses[Math.floor(Math.random() * data.businesses.length) - 1]
          response = []
          response.push "#{business.name} (rated: #{business.rating}/5 by #{business.review_count} people.)"
          response.push business.location.address

          msg.send response.join("\n")
          setTimeout (->
            msg.send business.url
          ), 2000
