# Description:
#   Make a little sparkline with unicode blocks
#
# Commands:
#   spark [numbers]

module.exports = (robot) ->
  blocks = ["\u2581", "\u2582", "\u2583", "\u2584","\u2585","\u2586","\u2587","\u2588"]
  max = (a) ->
    m = -9999
    for i in a
      if i > m
        m = i
    m

  robot.respond /spark (.+)/i, (msg) ->
    numbers = msg.match[1].split(' ').map (x) -> parseFloat(x)
    mymax = max(numbers)
    step = mymax / 7 || 1
    bars = numbers.map (n) ->
      index = Math.floor(n / step)
      blocks[index]

    msg.send bars.join(' ')
