# Description
#   Repeats the previous command directed at Smith.
#
# Commands:
#   smith [!!|redo]

module.exports = (robot) ->

  exports.lastCommand = ''

  # store the last thing directed at Smith in chat
  robot.respond /(.+)/i, (msg) ->
    command = msg.match[1]
    unless command.match /(!!|redo)/
      exports.lastCommand = command

  # repeat the last command directed at smith
  robot.respond /(!!|redo)/i, (msg) ->
    if exports.lastCommand?
      msg.message.text = "smith #{exports.lastCommand}"
      robot.receive msg.message
      msg.messsage.done = true
    else
      msg.send "I don't have a stored command that I can execute."

