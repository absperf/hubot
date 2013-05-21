# Description:
#   Search stack overflow and provide links to the first 5 questions
#
# Commands:
#   hubot howdoi <query> - Search for the query
#   hubot howdoi <query> with tags <tag list sperated by ,> - Search for the query limit to given tags

ZLIB = require('zlib')

module.exports = (robot) ->
  robot.respond /howdoi\s(.+)/i, (msg) ->
    re = RegExp("(.*) with tags (.*)", "i")
    opts = msg.match[1].match(re)

    if opts?
      soSearch msg, opts[1], opts[2].split(',')
    else
      soSearch msg, msg.match[1], []

soSearch = (msg, search, tags) ->
  data = ''

  msg.http("https://api.stackexchange.com/1.1/search")
    .query(site: 'stackoverflow', intitle: search, tagged: tags)
    .get( (err, req) ->
      req.addListener "response", (res) ->
        output = res

        if res.headers['content-encoding'] is 'gzip'
          output = ZLIB.createGunzip()
          res.pipe(output)

        output.on 'data', (d) ->
          data += d.toString('utf-8')

        output.on 'end', ()->
          parsedData = JSON.parse(data)
          if parsedData.error
            msg.send "Error searching stack overflow: #{parsedData.error.message}"
            return

          if parsedData.items.length > 1
            qs = for question in parsedData.items[0..5]
              "http://www.stackoverflow.com/questions/#{question.question_id} - #{question.title}"
            if (parsedData.total - 5) > 0
              qs.push "#{parsedData.total - 5} more..."
            for ans in qs
              msg.send ans
          else
            msg.reply "No questions found matching that search."
      )()




