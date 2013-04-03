# Description:
#   Comida Taco Truck Plugin
#
# Commands:
#   hubot where is the taco truck

module.exports = (robot) ->
  robot.respond /(where is) the( .+)? taco truck(\?)?/i, (msg) ->
    findTacoTruck msg

findTacoTruck = (msg) ->
  msg.http('http://www.eatcomida.com/wp-content/themes/eatcomida/includes/json-feed.php')
    .header('accept', 'application/json')
    .get() (err, res, body) ->
      nextEvent = JSON.parse(body)[0]

      msg.send nextEvent['title']
      setTimeout (-> msg.send nextEvent['url']), 2000

