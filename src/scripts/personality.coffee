# Description:
#   A 'personality' for Smith
#   Random greeting (and random chance of occurance) on room entry.
#   Random exclamation for posted links
#
# Commands:
#   None

Sudo = require('./sudo')

module.exports = (robot) ->

  sudo = new Sudo(robot)

  sudo.respond /make me a sandwich/, (msg) ->
    name = msg.message.user.name.split(' ')
    name = name[0] if name.length > 1
    msg.send "Okay #{name}, I'm making you a sandwich."

  robot.enter (msg) ->
    name = msg.message.user.name.split(' ')
    name = name[0] if name.length > 1
    message = greetings(name)
    randomMessage(msg, message, 5)

  robot.hear /(https?:\/\/[^\s]+)|(.+\.(png|gif|jpe?g))/i, (msg) ->
    randomMessage(msg, exclamations , 5)

  randomMessage = (msg, messages, multiplier) ->
    randomNumber = Math.floor(Math.random() * messages.length) * multiplier
    if randomNumber <= messages.length
      msg.send messages[randomNumber]

  greetings = (name) ->
    [ "Hello #{name}.",
      "Hi, #{name}, how's it going?",
      "What's up, #{name}?",
      "Greetings, #{name}.",
      "Buongiorno, #{name}.",
      "Bonjour, #{name}.",
      "Hola, #{name}.",
      "Aloha, #{name}.",
      "#{name}! Just the person we need!",
      "Heeeeeeeeeere's #{name}!"]

  exclamations = [
    'Wooooooo!',
    'Wow!',
    'Nice!',
    'Awesome!',
    'Whoa!',
    'Sweet!',
    'Neat!',
    'Daaaaaaaamn!' ]

