# A personality for Smith

module.exports = (robot) ->
  robot.enter (msg) ->
    name = msg.message.user.name.split(' ')
    randomGreeting msg, name[0] (message) -> msg.send message

  robot.hear /http.+[^(youtube|amazonaws|\.png|\.jpe?g|\.(g|t)iff?|pivotal|sysshep)]/, (msg) ->
    randomExclamation(message) -> msg.send message

randomExclamation = (message) ->
  exclamations = [
    "Wooooooo!",
    "Nice!",
    "Awesome!",
    "Whoa!",
    "Sweet"
  ]

  rand = Math.floor(Math.random() * exclamations.length)
  message exclamations[rand]


randomGreeting = (msg, name, message) ->
  greetings = [
    "Hello #{name}.",
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
    "So #{name} calls me at like 2am, super drunk - 'I need you, Smith.' So I... oh. Hello #{name}.",
    "Paint me like one of your French girls, #{name}"
  ]

  rand = Math.floor(Math.random() * greetings.length) * 4
  message greetings[rand]

