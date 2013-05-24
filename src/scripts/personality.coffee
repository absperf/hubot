# Description:
#   A 'personality' for Smith:
#     A random greeting on room entry (x% of the time)
#     A random exclamation for posted links (x% of the time)
#     The ability to teach Smith to respond to things he hears.
#
# Commands:
#   hubot when you hear [pattern] say [text]
#   hubot when you hear [pattern] play [command]
#   hubot when you hear [pattern] do [command]
#   hubot stop responding to [pattern]
#   hubot what do you remember

module.exports = (robot) ->

  robot.enter (msg) ->
    name = msg.message.user.name.split(' ')
    name = name[0] if name.length > 1
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
    randomMessage msg, greetings(name)

  robot.hear /(https?:\/\/[^\s]+)|(.+\.(png|gif|jpe?g))/i, (msg) ->
    exclamations = [
      'Wooooooo!',
      'Wow!',
      'Nice!',
      'Awesome!',
      'Whoa!',
      'Sweet!',
      'Neat!',
      'Daaaaaaaamn!' ]
    randomMessage msg, exclamations

  randomMessage = (msg, messages) ->
    if Math.floor(Math.random() * 7) == 0
      msg.send messages[Math.floor(Math.random() * messages.length)]

  # todo: hubot when you hear [pattern] from [user] say [text]

  unless robot.brain.data['memories']? # make sure this exists and is an array when we start up
    robot.brain.data.memories = []

  memorize = (memory) ->
    robot.brain.data.memories.push(memory)

  forget = (pattern) ->
    robot.brain.data.memories = robot.brain.data.memories.filter (m) -> m.pattern != pattern

  remember = (message) ->
    (robot.brain.data.memories.filter (m) -> message.match RegExp(m.pattern, 'i')).shift()

  robot.respond /what do you remember\??$/i, (msg) ->
    msg.send JSON.stringify(robot.brain.data.memories)

  robot.hear /^(.+)$/i, (msg) ->
    message = msg.match[1]

    unless message.match /^Smith:/
      if memory = remember(message)
        if memory.action
          msg.message.text = "Smith: #{memory.action}"
          robot.receive msg.message
        else if memory.sound
          msg.play memory.sound
        else if msg.message.user.name != 'Smith'
          msg.send memory.response
        msg.message.done = true

  robot.respond /when you hear (.+?) say (.+?)$/i, (msg) ->
    pattern = msg.match[1]
    response = msg.match[2]

    forget(pattern)
    msg.send "When I hear #{pattern} I'll say #{response}"
    msg.message.done = true
    memory =
      pattern:  pattern
      response: response
      action:   false
      sound:    false
    memorize memory

  robot.respond /when you hear (.+?) play (.+?)$/i, (msg) ->
    pattern = msg.match[1]
    sound = msg.match[2]

    forget(pattern)
    msg.send "When I hear #{pattern} I'll play #{sound}"
    msg.message.done = true
    memory =
      pattern:  pattern
      response: false
      action:   false
      sound:    sound
    memorize memory

  robot.respond /when you hear (.+?) do (.+?)$/i, (msg) ->
    pattern = msg.match[1]
    action = msg.match[2]

    forget(pattern)
    msg.send "When I hear #{pattern} I'll do #{action}"
    msg.message.done = true
    memory =
      pattern:  pattern
      response: false
      action:   action
      sound:    false
    memorize memory

  robot.respond /stop responding to (.+?)$/i, (msg) ->
    pattern = msg.match[1]

    forget(pattern)
    msg.send "I'll stop responding to #{pattern}"
    msg.message.done = true
