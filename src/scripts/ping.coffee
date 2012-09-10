# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot ping - Reply with pong
#   hubot echo [text] - Reply back with [text]
#   hubot time - Reply with current time
#   hubot die - End hubot process

module.exports = (robot) ->
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
      "All these moments will be lost in time. Like ... tears in the rain. Time to die."]
    rand = Math.floor(Math.random() * messages.length)
    msg.send messages[rand - 1]
    setTimeout (->
      process.exit 0
    ), 2000

