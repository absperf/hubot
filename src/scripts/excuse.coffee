# Description
#   Ask smith for an excuse
#
# Commands:
#   hubot give me an excuse

http = require('http')

module.exports = (robot) ->
  options = {host: 'www.programmingexcuses.com', port: 80, path: '/'}
  
  robot.respond /give me an excuse.?/i, (msg) ->
    http.get options, (response) ->
      string = ""

      response.on 'data', (chunk) ->
        string += chunk

      response.on 'end', () ->
        pattern = /<a [^>]+>([^<]+)</
        excuses = string.match pattern
        msg.send excuses[1]

