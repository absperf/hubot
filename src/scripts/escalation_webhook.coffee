# Description:
#   Output escalations in chatroom via webhook.
#
# Commands:
#   None

module.exports = (robot) ->
  dev = process.env.DEV
  robot.router.post '/smith/escalation_hook', (req, res) ->
    body = req.body
    msg = ""
    console.log req.body
    for esc in body
      msg += "Alert on #{esc.client_name} (#{esc.escalation_href})\n"
 
    robot.messageRoom room, "Alert: " + msg
    res.end "message sent"


