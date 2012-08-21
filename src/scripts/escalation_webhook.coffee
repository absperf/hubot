# Description:
#   Output escalations in chatroom via webhook.
#
# Commands:
#   Just wait for alerts to happen

module.exports = (robot) ->
  room = process.env.HUBOT_CAMPFIRE_ROOMS
  robot.router.post '/smith/escalation_hook', (req, res) ->
    body = req.body
    console.log req.client
    msg = "There was an escalation on #{body.client.name} affecting #{body.host}:"
    for esc in body.escalations
      msg += "#{esc.message} (#{esc.escalation_href})\n"

    robot.messageRoom room, "Alert: " + msg
    res.end "message sent"


