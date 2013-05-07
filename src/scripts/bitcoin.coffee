# Description:
#   Get the current bitcoin value and 24 hour info from MTGOX
#
# Commands:
#   hubot bitcoin (info)

module.exports = (robot) ->
  robot.respond /bitcoin( info)?/i, (msg) ->
    msg.http('http://data.mtgox.com/api/1/BTCUSD/ticker')
      .header('accept', 'application/json')
      .get() (err, res, body) ->
        response = JSON.parse(body).return

        message = [
         "1 BTC is worth $#{response.last.value} USD",
         "Over the past 24 hours:",
         "  low:          $#{response.low.value} USD",
         "  average:      $#{response.avg.value} USD",
         "  high:         $#{response.high.value} USD",
         "  trade volume: #{response.vol.value} BTC ($#{response.vol.value * response.avg.value} USD)"
        ]

        msg.send message.join("\n")

