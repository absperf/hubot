# Description:
#   Output escalations in chatroom via webhook.
#
# Commands:
#   None

module.exports = (robot) ->
  room = process.env.OPS
  robot.router.post '/smith/escalation_hook', (req, res) ->
    body = req.body
    msg = ""
    for esc in body
      msg += "Alert on #{esc.client_name} (#{esc.escalation_href})\n"
 
    robot.messageRoom room, "Alert: " + msg
    res.end "message sent"


