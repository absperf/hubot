# Description:
#   Find Food Trucks
#
# Commands:
#   hubot what['s|is] for lunch(?)?

module.exports = (robot) ->

  sameDay = (date) ->
    today = new Date()

    date.getUTCFullYear() == today.getUTCFullYear() && date.getUTCMonth() == today.getUTCMonth() && date.getUTCDate() == today.getUTCDate()

  robot.respond /what('s| is) for lunch(\?)?/i, (msg) ->
    msg.http("https://api.twitter.com/1/lists/statuses.json?slug=boulder-mobile-food&owner_screen_name=trinary&count=50")
      .header('accept', 'application/json')
      .get() (err, res, body) ->
        statuses = JSON.parse(body)

        for status in statuses
          date = new Date(status.created_at)

          if sameDay(date) && status.text.match(/(flatiron(s)?\s+(business|biz)\s+park|markit(\s+on\s+demand)?/i) and !status.text.match(/not/i)
            msg.send "#{status.user.name}: #{status.text}"


