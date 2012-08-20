# Greeting for entering the room

module.exports = (robot) ->
  robot.enter (msg) ->
    msg.send "Hello, #{msg.message.user.name}"
