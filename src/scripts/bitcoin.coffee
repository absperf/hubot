# Description:
#   Get the current bitcoin valuation and info on the past 24 hours from MTGOX
#
# Commands:
#   hubot bitcoin (info)

module.exports = (robot) ->
  robot.respond /bitcoin( info)?/i, (msg) ->
    msg.http('http://data.mtgox.com/api/1/BTCUSD/ticker')
      .header('accept', 'application/json')
      .get() (err, res, body) ->
        response = JSON.parse(body).return
        msg.send "1 BTC is currently worth $#{response.last.value} USD"
        msg.send "Over the past 24 hours:"
        msg.send "  low:          $#{response.low.value} USD"
        msg.send "  average:      $#{response.avg.value} USD"
        msg.send "  high:         $#{response.high.value} USD"
        msg.send "  trade volume: #{response.vol.value} BTC ($#{response.vol.value * response.avg.value} USD)"

