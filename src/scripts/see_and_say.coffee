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
    smith = robot.usersForFuzzyName('Smith')[0]
    smith.cowPhrase = message
    smith.save

    msg.send cowSay(smith.cowPhrase)

