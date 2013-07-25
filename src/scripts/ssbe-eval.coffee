# Description:
#   Evaluate some Ruby code with Datapathy loaded.
#
# Commands:
#   ssbe-eval [backend] [code]

spawn = require('child_process').spawn

module.exports = (robot) ->

  robot.respond /ssbe-eval (.+com) (.+)/i, (msg) ->
    backend = msg.match[1]
    code = msg.match[2]
    user = process.env.SSBE_USER
    pass = process.env.SSBE_PASS
    ssbe = spawn('ruby', ['-ractive_support', '-rdatapathy', '-rssbe/models/core', '-rssbe/models/alarm', '-rssbe/models/analytics', '-rssbe/models/webwalk', '-e', "Datapathy.adapter = Datapathy.adapters[:ssbe] = Datapathy::Adapters::SsbeAdapter.new(username: '#{user}', password: '#{pass}', backend: '#{backend}'); eval '#{code}'"])

    output = []
    ssbe.stdout.on 'data', (data) -> output.push(data)
    ssbe.stderr.on 'data', (data) -> output.push(data)
    ssbe.on 'exit', (code) ->
      unless code == 0
        msg.send "There was an error evaluating that Ruby code."
      msg.send output.join("\n")

