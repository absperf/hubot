# Description:
#   Output escalations in chatroom via webhook.
#
# Commands:
#   None

module.exports = (robot) ->
  dev = process.env.DEV
  robot.router.post '/smith/escalation_hook', (req, res) ->
    body = req.body
    for esc in body
      robot.messageRoom dev, "Alert on #{esc.client_name}: #{esc.message} (#{esc.escalation_href})"

    res.end "message sent"


