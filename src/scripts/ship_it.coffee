# Description:
#   Ship Stuff
#
# Commands:
#   ship it

module.exports = (robot) ->

  ships = [
    'http://shipitsquirrel.github.com/images/squirrel.png',
    'http://shipitsquirrel.github.com/images/ship%20it%20squirrel.png',
    'http://i0.reflectornetwork.com/images-4/aW1nLnNraXRjaC5jb20vMjAxMDA3MTQtZDZxNTJ4YWpmaDRjaW14cjM4ODh5Yjc3cnUuanBn.png'
  ]

  robot.hear /ship it!?/i, (msg) ->
    msg.send ships[Math.floor(Math.random()*ships.length)]
