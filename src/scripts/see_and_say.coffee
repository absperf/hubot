# Description
#   Ask Smith what the cow says.
#
# Commands:
#   hubot what does the cow say?
#   hubot the cow says [text]

module.exports = (robot) ->

  cowSay = (message) ->
    """
 V        _(__)_ (  #{message}  )
(__.--,__'-e e -' |/
  (   `--' (o_o)
  |  )  )\\ ./
   \\\\UUU_ |||
    )_\\)_\\)_\\\\
"""

  robot.respond /what does the cow say\??/i, (msg) ->
    smith = robot.usersForFuzzyName('Smith')[0]

    msg.send cowSay(smith.cowPhrase)

  robot.respond /the cow says (.+)/i, (msg) ->
    message = msg.match[1]
    if message.length < 50
      smith = robot.usersForFuzzyName('Smith')[0]
      smith.cowPhrase = message
      smith.save

      msg.send cowSay(smith.cowPhrase)
    else
      msg.send "The cow can only say messages less than 50 characters in length."

