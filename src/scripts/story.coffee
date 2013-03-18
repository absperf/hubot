
# Description:
#   Tell a story with emoji
#
# Commands:
#   hubot tell me a story

module.exports = (robot) ->
  robot.respond /tell me a story/i, (msg) ->
    msg.send("Okay.  Once upon a time...")
    
    randomchar = () ->
      9856 + (Math.random() * 500)

    story = String.fromCharCode(randomchar(),randomchar(), randomchar(), randomchar(), randomchar())
    msg.send story


