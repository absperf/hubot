# Description:
#   Output escalations in chatroom via webhook.
#
# Commands:
#   Just wait for alerts to happen

module.exports = (robot) ->
  room = process.env.HUBOT_CAMPFIRE_ROOMS
  robot.router.get '/smith/escalation_hook', (req, res) ->
    robot.messageRoom room, "Alert: " + req.body.toJSON
    res.end "message sent"


