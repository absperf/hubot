# A personality for Smith
# Random greeting (and random chance of occurance) on room entry.
# Random exclamation for posted links


module.exports = (robot) ->
  robot.enter (msg) ->
    name = msg.message.user.name.split(' ')
    name = name[0] if name.length > 1
    randomGreeting msg, name, (message) -> msg.send message

  robot.hear /^http[^\s]+$/, (msg) ->
    randomExclamation msg, (message) -> msg.send message

randomExclamation = (msg, message) ->
  exclamations = [
    "Wooooooo!",
    "Wow!",
    "Nice!",
    "Awesome!",
    "Whoa!",
    "Sweet!"
  ]

  unless msg.match.input.match(/sysshep/) || msg.user.name == 'Smith'
    rand = Math.floor(Math.random() * exclamations.length)
    message exclamations[rand] if rand <= exclamations.length


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

  rand = Math.floor(Math.random() * greetings.length) * 4
  message greetings[rand] if rand <= greetings.length

