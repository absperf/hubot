# Description:
#   Tweet Comcast everytime we lose our internet connection.
#
# Commands:
#   none

OS = require('child_process')
OAuth = require('oauth').OAuth

c_key    = process.env.TWITTER_CONSUMER_KEY
c_secret = process.env.TWITTER_CONSUMER_SECRET
a_key    = process.env.TWITTER_ACCESS_KEY
a_secret = process.env.TWITTER_ACCESS_SECRET

oAuth = new OAuth(
  "http://twitter.com/oauth/request_token",
  "http://twitter.com/oauth/access_token",
  c_key,
  c_secret,
  "1.0A",
  null,
  "HMAC-SHA1")

module.exports = (robot) ->

  epoch = () -> (new Date).getTime() / 1000

  tweet_downtime = (time) ->
    message = {"status" : "Comcast was down for #{time}"}
    update  = "https://api.twitter.com/1.1/statuses/update.json"
    status  = "https://twitter.com/smithbot_api/status/"

    oAuth.post update, a_key, a_secret, message, (error, data) ->
      response = JSON.parse(data)

      if error
        for error in response.errors
          robot.messageRoom process.env.DEV, error.message
      else
        robot.messageRoom process.env.DEV, (status + response.id_str)

  robot.brain.data.routerPing = 0

  ping = () ->
    OS.spawn('ping', ['-c1', process.env.ROUTER_IP]).on 'exit', (code) ->
      if code == 0
        if robot.brain.data['routerDown']?

          time = []
          difference = epoch() - robot.brain.data.routerDown

          hour = Math.floor(difference / 3600)
          time.push("#{hour} hours") if hour > 0

          minute = Math.floor(difference % 3600 / 60)
          time.push("#{minute} minutes") if minute > 0

          second = Math.floor(difference % 60)
          time.push("#{second} seconds") if second > 0

          tweet_downtime(time.join ' ')

          delete robot.brain.data.routerDown
          robot.brain.data.routerPing = 0
      else
        robot.brain.data.routerPing += 1

        if robot.brain.data.routerPing == 3
          robot.brain.data.routerDown = epoch() + 30

      setTimeout (-> ping() ), 10000

  ping()

