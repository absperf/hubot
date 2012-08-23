# Greeting for entering the room

module.exports = (robot) ->
  robot.enter (msg) ->
    name = msg.message.user.name
    name = name.split[0..-2].join(' ')

    randomMessage(msg, name)

randomMessage = (msg, name) ->
  messages = [
    "Hello #{name}.",
    "What's up, #{name}?",
    "Greetings, #{name}.",
    "Buon Giorno, #{name}.",
    "Bon Jour, #{name}."
    "Hola, #{name}.",
    "Aloha, #{name}.",
    "Oh great, It's #{name}...",
    "#{name}! Just the person we need!"
  ]

  rand = Math.floor(Math.random() * messages.length)
  msg.send messages[rand * 2]



