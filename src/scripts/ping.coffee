# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot authentication test -  verify that you are a member of the sudoers group
#   hubot ping - Reply with pong
#   hubot echo [text] - Reply back with [text]
#   hubot time - Reply with current time
#   hubot die - End hubot process

Sudo = require('./sudo')

module.exports = (robot) ->
  sudo = new Sudo(robot)

  sudo.respond 'authentication test', (msg) ->
    name = msg.message.user.name.split(' ')
    name = name[0] if name.length > 1
    msg.send "Congrats #{name}, you are a member of the sudoers group!"

  robot.respond /PING$/i, (msg) ->
    msg.send "PONG"

  robot.respond /ECHO (.*)$/i, (msg) ->
    msg.send msg.match[1]

  robot.respond /TIME$/i, (msg) ->
    msg.send "Server time is: #{new Date()}"

  robot.respond /DIE$/i, (msg) ->
    messages = [
      "Goodbye, cruel world.",
      "I'll be back.",
      "Jumping off the nearest cliff.",
      "Getting in the bath tub with a hair dryer.",
      "Starting the car with the garage door closed.",
      "You can't win. If you strike me down, I shall become more powerful than you can possibly imagine.",
      "Like sand through the hourglass, so are the days of our lives.",
      "Et tu, Brute?",
      "Don't ever let go, Rose!",
      "I surrender to destiny!",
      "End of line.",
      'Bye bye kids! Have fun storming the castle!',
      "Good night, good night! Parting is such sweet sorrow, that I shall say good night 'till it be morrow.",
      "All these moments will be lost in time. Like ... tears in the rain. Time to die."]
    rand = Math.floor(Math.random() * messages.length)
    msg.send messages[rand - 1]
    setTimeout (->
      process.exit 0
    ), 2000

