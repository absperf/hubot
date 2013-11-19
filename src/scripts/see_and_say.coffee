# Description
#   Ask Smith what the cow says.
#
# Commands:
#   hubot what does the cow say?
#   hubot the cow says [text]
#   hubot list cowfiles

spawn = require('child_process').spawn

module.exports = (robot) ->

  cowSay = (message, animal, action, callback) ->
    animal = (if /cow/i.test(animal) then "default" else animal)

    proc = spawn "cow#{action}", ['-f', animal, message]

    proc.stdout.on 'data', (data) ->
      callback data.toString()

    proc.stderr.on 'data', (data) ->
      callback "error:  " + data.toString()

  cowList = (callback) ->
    proc = spawn "cowsay", ["-l"]

    proc.stdout.on 'data', (data) ->
      # Cut the first line from the string
      callback data.toString().split('\n').slice(1).join('\n')

    proc.stderr.on 'data', (data) ->
      callback "error:  " + data.toString()

  robot.respond /what does the (\S+) (say|think)\??/i, (msg) ->
    smith = robot.usersForFuzzyName(robot.name)[0]
    animal = msg.match[1]
    action = msg.match[2]

    cowSay smith["#{animal}#{action}Phrase"], animal, action, (stdout) ->
      msg.send stdout
    
  robot.respond /list cowfiles/i, (msg) ->
    cowList (stdout) ->
      msg.send stdout

  robot.respond /the (\S+) (say|think)s (.+)/i, (msg) ->
    animal = msg.match[1]
    action = msg.match[2]
    message = msg.match[3]
    smith = robot.usersForFuzzyName(robot.name)[0]
    smith["#{animal}#{action}Phrase"] = message
    smith.save

    cowSay smith["#{animal}#{action}Phrase"], animal, action, (stdout) ->
      msg.send stdout

