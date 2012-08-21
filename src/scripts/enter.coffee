# Greeting for entering the room

module.exports = (robot) ->
  robot.enter (msg) ->
    name = msg.message.user.name
    name = name.split[0..-2].join(' ')
    msg.send random_message(name)

randomMessage(name) ->

  messages = (name) ->
    "Hello"

