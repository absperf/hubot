# Description:
#   Comida Taco Truck Plugin
#
# Commands:
#   hubot where is the taco truck

module.exports = (robot) ->
  robot.respond /where is the taco truck/i, (msg) ->
    findTacoTruck msg, (message) ->  msg.send message

findTacoTruck = (msg, message) ->
  msg.http('http://www.eatcomida.com/wp-content/themes/eatcomida/includes/json-feed.php')
    .header('accept', 'application/json')
    .get() (err, res, body) ->
      nextStop = JSON.parse(body)[0]

      now = new Date
      nowEpoch = now.getTime() / 1000

      times = [new Date(nextStop['start']), new Date(nextStop['end'])]

      startEpoch = times[0].getTime() / 1000
      endEpoch = times[1].getTime() / 1000

      if nowEpoch < startEpoch
        buildMessage(msg, 'next stop', times, nextStop, message)
      else if nowEpoch > startEpoch && nowEpoch < endEpoch
        buildMessage(msg, 'current location', times, nextStop, message)
      else
        message 'I have no idea where the truck is.'

buildMessage = (msg, event, times, location, message) ->
  response = [ "The Comida Taco Truck's #{event}: #{location['title']}" ]

  if location['allDay']
    response.push "They will be there all day."
  else
    startHour = times[0].getHours()
    startHour = startHour - 12 if startHour > 12
    startMinute = times[0].getMinutes()

    endHour = times[1].getHours()
    endHour = endHour - 12 if endHour > 12
    endMinute = times[1].getMinutes()

    response.push "They will be there from #{startHour}:#{startMinute} to #{endHour}:#{endMinute}."

  response.push location['url']

  message response.join("\n")

