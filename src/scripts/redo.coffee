# Description
#   Repeats the previous command directed at Smith.
#
# Commands:
#   smith [!!|last command|redo]

module.exports = (robot) ->
  robot.respond /(.+)/i, (msg) ->
    store msg.match[1]

  robot.respond /(!!|last command|redo)/i, (msg) ->

    if exports.last_command?
      msg['message']['text'] = "smith #{exports.last_command}"
      robot.receive msg['message']
      msg['message']['done'] = true
    else
      msg.send "I don't have a stored command that I can execute."

store = (command) ->
  exports.last_command = command unless command.match /(!!|last command|redo)/
