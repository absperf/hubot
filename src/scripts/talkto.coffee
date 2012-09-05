# Description:
#   Make smith talk to other rooms for you.
#
# Commands:
#   hubot tell [room] [message] - send message to room (ops or dev)

rooms = {
  dev: process.env.DEV
  ops: process.env.OPS
}

module.exports = (robot) ->
  robot.respond /tell (\w+) (.+)/, (msg) ->
    room = rooms[msg.match[1]]
    if room?
      robot.messageRoom room, msg.match[2]
    else
      msg.send "Can only message#{" "+k for k, v of rooms}"


