# Description:
#   A 'personality' for Smith
#   Random greeting (and random chance of occurance) on room entry.
#   Random exclamation for posted links
#
# Commands:
#   None

module.exports = (robot) ->
  robot.enter (msg) ->
    name = msg.message.user.name.split(' ')
    name = name[0] if name.length > 1

    randomMessage msg, greetings(name), 5, (message) -> msg.send message

  robot.hear /(https?:\/\/[^\s]+)|(.+\.(png|gif|jpe?g))/i, (msg) ->
    randomMessage msg, exclamations , 5, (message) -> msg.send message

  robot.respond /i\slove\syou/i, (msg) ->
    randomMessage msg, loves, 1, (message) -> msg.send message

randomMessage = (msg, messages, multiplier, message) ->
  randomNumber = Math.floor(Math.random() * messages.length) * multiplier
  if randomNumber <= message.length
    message messages[randomNumber - 1]



greetings = (name) ->
  [ "Hello #{name}.",
    "Hi, #{name}, how's it going?",
    "What's up, #{name}?",
    "Greetings, #{name}.",
    "Buongiorno, #{name}.",
    "Bonjour, #{name}."
    "Hola, #{name}.",
    "Aloha, #{name}.",
    "#{name}! Just the person we need!",
    "Heeeeeeeeeere's #{name}!",
    "Draw me like one of your French girls, #{name}" ]

exclamations = [
  'Wooooooo!',
  'Wow!',
  'Nice!',
  'Awesome!',
  'Whoa!',
  'Sweet!',
  'Neat!',
  'Daaaaaaaamn!' ]

loves = [
  "I love you too!",
  "Awww, right back 'atcha!",
  "I love you but I'm not /in/ love with you.",
  "Can't we just be friends?",
  "What's love got to do with it?" ]
