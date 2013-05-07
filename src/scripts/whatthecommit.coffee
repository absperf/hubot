# Description:
#   Get a random commit message from whatthecommit.com
#
# Commands:
#   hubot wtc(?)
#   hubot whatthecommit(?)

module.exports = (robot) ->
  robot.respond /(wtc|whatthecommit)(\?)?/i, (msg) ->
    msg.http('http://www.whatthecommit.com/index.txt')
      .get() (err, res, body) -> msg.send body.trim()

