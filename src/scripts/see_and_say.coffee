# Description
#   Ask Smith what the cow says.
#
# Commands:
#   hubot what does the cow say?
#   hubot the cow says [text]
#   hubot list cowfiles

childproc = require 'child_process'

module.exports = (robot) ->

  cowSay = (message, animal, callback) ->
    childproc.exec "cowsay -f \"#{animal}\" #{message}", (error, stdout, stderr) ->
      callback stdout, error

  cowList = (callback) ->
    childproc.exec "cowsay -l | tail -n +2", (error, stdout, stderr) ->
      callback stdout

  robot.respond /what does the (\w+) say\??/i, (msg) ->
    smith = robot.usersForFuzzyName('Smith')[0]
    animal = msg.match[1]

    cowSay smith.cowPhrase, (if /cow/i.test(animal) then "default" else animal), (stdout, error) ->
      if error is null
        msg.send stdout
      else
        cowSay smith.cowPhrase, "default", (stdout, error) ->
          msg.send stdout
    
  robot.respond /list cowfiles/i, (msg) ->
    cowList (stdout, error) ->
      msg.send stdout

  robot.respond /the (\w+) says (.+)/i, (msg) ->
    animal = msg.match[1]
    message = msg.match[2]
    smith = robot.usersForFuzzyName('Smith')[0]
    smith.cowPhrase = message
    smith.save

    cowSay smith.cowPhrase, (if /cow/i.test(animal) then "default" else animal), (stdout, error) ->
        msg.send stdout

