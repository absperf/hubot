# Utility commands surrounding Hubot uptime.
module.exports = (robot) ->
  robot.hear /([A-z]+)(.*) has entered the room./, (msg) ->
    msg.send "Hello #{msg.match[1]}!"

