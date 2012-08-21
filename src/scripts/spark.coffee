# Description:
#   Make a little sparkline with unicode blocks
#
# Commands:
#   spark [numbers]
#   sparkmetric [metric_href]

mime = [ "application/vnd.absperf.ss#{v}j1+json" for v in "amk" ].join(', ')
credentialsList =
  'core.ssbe.localhost': process.env.DEFAULT_CREDENTIALS
  'core.ops.sysshep.com': process.env.STANDARD_CREDENTIALS
  'core.ss-internal2.den.sysshep.com': process.env.STANDARD_CREDENTIALS
  'core.ssbe06.qwest.sysshep.com': process.env.STANDARD_CREDENTIALS


module.exports = (robot) ->
  blocks = ["\u2581", "\u2582", "\u2583", "\u2584","\u2585","\u2586","\u2587","\u2588"]
  max = (a) ->
    m = -9999
    for i in a
      if i > m
        m = i
    m

  createBars = (values) -> 
    mymax = max(values)
    step = mymax / 7 || 1
    bars = values.map (n) ->
      index = Math.floor(n / step)
      blocks[index]

  robot.respond /spark (.+)/i, (msg) ->
    numbers = msg.match[1].split(' ').map (x) -> parseFloat(x)
    bars = createBars(numbers)
    msg.send bars.join(' ')

  robot.respond /sparkmetric (.+)/i, (msg) ->
    href = msg.match[1]
    auth = ""
    for credential, value of credentialsList
      auth = value if href.match(credential)

    username = process.env.SSBE_USER
    password = process.env.SSBE_PASS

    href = msg.match[1]
    msg.http(href)
      .auth(auth)
      .header('accept', mime)
      .get() (err, res, body) ->
        body = JSON.parse(body)
        metric_name = body.name
        observations_href = body.observations_href

        msg.http(observations_href)
          .auth(auth)
          .header('accept', mime)
          .get() (err, res, body) ->
            items = JSON.parse(body).items
            values = items.map (item) -> item.value
            bars = createBars(values)
            msg.send metric_name + " " + bars.join('')

