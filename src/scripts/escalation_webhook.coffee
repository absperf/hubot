# Description:
#   Output escalations in chatroom via webhook.
#
# Commands:
#   Just wait for alerts to happen

module.exports = (robot) ->
  room = process.env.OPS
  robot.router.post '/smith/escalation_hook', (req, res) ->
    body = req.body
    msg = "There was an escalation on #{body.client.name} affecting #{body.client.host}:\n"
    for esc in body.client.escalations
      msg += "#{esc.message} (#{esc.escalation_href})\n"

    robot.messageRoom room, "Alert: " + msg
    res.end "message sent"


