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

  cowSay = (message, animal, action, callback) ->
    animal = (if /cow/i.test(animal) then "default" else animal)

    proc = spawn "cow#{action}", ['-f', animal, message]

    proc.stdout.on 'data', (data) ->
      callback data.toString()

    proc.stderr.on 'data', (data) ->
      callback "error:  " + data.toString()

  cowList = (callback) ->
    exec "cowsay -l | tail -n +2", (error, stdout, stderr) ->
      callback stdout

  robot.respond /what does the (\w+) (say|think)\??/i, (msg) ->
    smith = robot.usersForFuzzyName(robot.name)[0]
    animal = msg.match[1]
    action = msg.match[2]

    cowSay smith["#{animal}#{action}Phrase"], animal, action, (stdout) ->
      msg.send stdout
    
  robot.respond /list cowfiles/i, (msg) ->
    cowList (stdout, error) ->
      msg.send stdout

  robot.respond /the (\w+) (say|think)s (.+)/i, (msg) ->
    animal = msg.match[1]
    action = msg.match[2]
    message = msg.match[3]
    smith = robot.usersForFuzzyName(robot.name)[0]
    smith["#{animal}#{action}Phrase"] = message
    smith.save

    cowSay smith["#{animal}#{action}Phrase"], animal, action, (stdout) ->
      msg.send stdout

