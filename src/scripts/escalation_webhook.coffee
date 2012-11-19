# Description:
#   Output escalations in chatroom via webhook.
#
# Commands:
#   None

module.exports = (robot) ->
  dev = process.env.DEV
  ops = process.env.OPS
  robot.router.post '/smith/escalation_hook', (req, res) ->
    body = req.body
    msg = ""
    for esc in body
      msg += "Alert on #{esc.client_name}: #{esc.message} (#{esc.escalation_href})\n"
 
    robot.messageRoom dev, "Alert: " + msg
    robot.messageRoom ops, "Alert: " + msg
    res.end "message sent"


