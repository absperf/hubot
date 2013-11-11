# Description
#   Ask Smith what the cow says.
#
# Commands:
#   hubot what does the cow say?
#   hubot the cow says [text]
#   hubot list cowfiles

spawn = require('child_process').spawn
exec = require('child_process').exec

module.exports = (robot) ->

  cowSay = (message, animal, callback) ->
    animal = (if /cow/i.test(animal) then "default" else animal)

    proc = spawn "cowsay", ['-f', animal, message]

    proc.stdout.on 'data', (data) ->
      callback data.toString()

    proc.stderr.on 'data', (data) ->
      process.stderr.write data

  cowList = (callback) ->
    exec "cowsay -l | tail -n +2", (error, stdout, stderr) ->
      callback stdout

  robot.respond /what does the (\w+) say\??/i, (msg) ->
    smith = robot.usersForFuzzyName(robot.name)[0]
    animal = msg.match[1]

    cowSay smith.cowPhrase, animal, (stdout) ->
      msg.send stdout
    
  robot.respond /list cowfiles/i, (msg) ->
    cowList (stdout, error) ->
      msg.send stdout

  robot.respond /the (\w+) says (.+)/i, (msg) ->
    animal = msg.match[1]
    message = msg.match[2]
    smith = robot.usersForFuzzyName(robot.name)[0]
    smith.cowPhrase = message
    smith.save

    cowSay smith.cowPhrase, animal, (stdout) ->
      msg.send stdout

