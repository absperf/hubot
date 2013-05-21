# Lookup anything on WolframAlpha
#
# Commands:
#   hubot lookup [query]

Wolfram = require('wolfram').createClient(process.env.WOLFRAM_APP_ID)

module.exports = (robot) ->
  robot.respond /(lookup) (.*)$/i, (msg) ->
    Wolfram.query msg.match[2], (e, result) ->
      if result and result.length > 0
        msg.send result[1]['subpods'][0]['value']
      else
        msg.send 'Hmm...not sure'
