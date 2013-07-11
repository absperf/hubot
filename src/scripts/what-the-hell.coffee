# Description
#   Echo the last 100 lines of Smith's log
#
# Commands:
#   smith what the [hell|heck|etc...]

spawn = require('child_process').spawn

module.exports = (robot) ->

  robot.respond /what the [a-z]{4}/i, (msg) ->

    output = []
    tail = spawn('tail', ['-n100', '/home/ubuntu/nohup.out'])
    tail.stdout.on 'data', (data) -> output.push(data)
    tail.stderr.on 'data', (data) -> output.push(data)
    tail.on 'exit', (code) ->
      if code == 0
        msg.send "You tell me. Here's the last 100 lines of my log."
      else
        msg.send "I can't even read my own log."

      setTimeout (-> msg.send output.join("\n")), 2000
