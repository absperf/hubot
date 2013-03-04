# Description:
#
# Commands:
#   hubot gino me - Receive a Gino
#   hubot gino bomb - Throw down some Ginos.

module.exports = (robot) ->

  robot.respond /gino me/i, (msg) ->
    msg.message.text = 'smith image me gino lucero'
    robot.receive msg.message
    msg['message']['done'] = true

  robot.respond /gino bomb( (\d+))?/i, (msg) ->
    msg.message.text = 'smith image me gino lucero'
    robot.receive msg.message for i in [1..5]
    msg['message']['done'] = true
