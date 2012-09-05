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
    randomGreeting msg, name, (message) -> msg.send message

  robot.hear /https?:\/\/[^\s]+/, (msg) ->
    randomExclamation msg, (message) -> msg.send message

  robot.hear /(?=.*i)(?=.*love)(?=.*(smith|you)).*/i, (msg) ->
    randomLoveMessage msg, (message) -> msg.send message

randomLoveMessage = (msg, message) ->
  loveMessages = [
    "I love you too!",
    "Awww, right back 'atcha!",
    "I love you but I'm not /in/ love with you.",
    "Can't we just be friends?",
    "What's love got to do with it?"
  ]
  rand = Math.floor(Math.random() * loveMessages.length)
  message loveMessages[rand - 1]

randomExclamation = (msg, message) ->
  exclamations = [
    'Wooooooo!',
    'Wow!',
    'Nice!',
    'Awesome!',
    'Whoa!',
    'Sweet!',
    'Neat!',
    'Daaaaaaaamn!'
  ]
  unless msg.match.input.match(/sysshep/) || msg.message.user.name == 'Smith'
    rand = Math.floor(Math.random() * exclamations.length) * 5
    message exclamations[rand - 1] if rand <= exclamations.length

randomGreeting = (msg, name, message) ->
  greetings = [
    "Hello #{name}.",
    "Hi, #{name}, how's it going?",
    "What's up, #{name}?",
    "Greetings, #{name}.",
    "Buongiorno, #{name}.",
    "Bonjour, #{name}."
    "Hola, #{name}.",
    "Aloha, #{name}.",
    "Oh great, It's #{name}...",
    "#{name}, the hero that API deserves, but not the one it needs right now."
    "#{name}! Just the person we need!",
    "Heeeeeeeeeere's #{name}!",
    "Draw me like one of your French girls, #{name}"
  ]
  rand = Math.floor(Math.random() * greetings.length) * 5
  message greetings[rand - 1] if rand <= greetings.length

