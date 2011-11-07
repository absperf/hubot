# Utility commands surrounding Hubot uptime.
module.exports = (robot) ->
  robot.hear /has entered the room./, (msg) ->
    msg.send "Hello!"

