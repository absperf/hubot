# Description
#   Ask Smith what the cow says.
#
# Commands:
#   hubot what does the cow say?
#   hubot the cow says [text]

module.exports = (robot) ->

  exports.cowPhrase = 'moo!'

  robot.respond /what does the cow say\??/i, (msg) ->
    msg.send """
 V        _(__)_ (  #{exports.cowPhrase}  )
(__.--,__'-e e -' |/
  (   `--' (o_o)
  |  )  )\\ ./
   \\\\UUU_ |||
    )_\\)_\\)_\\\\
"""

  robot.respond /the cow says (.+)/i, (msg) ->
    message = msg.match[1]
    if message.length < 50
      exports.cowPhrase = message
      msg.send "Okay, the cow says #{message}"

