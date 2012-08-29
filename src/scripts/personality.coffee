# Greeting for entering the room

module.exports = (robot) ->
  robot.enter (msg) ->
    name = msg.message.user.name
    name = name.split(' ')[0..-2].join(' ')
    randomGreeting(msg, name)

randomGreeting = (msg, name) ->
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

  rand = Math.floor(Math.random() * greetings.length)
  rand = rand * 4

  msg.send greetings[rand] if greetings.length >= rand
