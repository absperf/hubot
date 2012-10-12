# Description:
#   Comida Taco Truck Plugin
#
# Commands:
#   hubot where is the taco truck

module.exports = (robot) ->
  robot.respond /(where is) the taco truck(\?)?/i, (msg) ->
    findTacoTruck msg

findTacoTruck = (msg) ->
  msg.http('http://www.eatcomida.com/wp-content/themes/eatcomida/includes/json-feed.php')
    .header('accept', 'application/json')
    .get() (err, res, body) ->
      nextEvent = JSON.parse(body)[0]

      now = new Date
      start = new Date(nextEvent['start'])
      end = new Date(nextEvent['end'])

      times = [start, end]

      if epoch(now) < epoch(start)
        buildMessage(msg, 'next stop', times, nextEvent)
      else if epoch(now) > epoch(start) && epoch(now) < epoch(end)
        buildMessage(msg, 'current location', times, nextEvent)
      else
        msg.send 'I have no idea where the truck is.'

epoch = (time) ->
  time.getTime() / 1000

timeDuration = (time) ->
  hour = time.getHours() - 6 # time zone hax. fixme
  minute = time.getMinutes()

  if hour > 12
    "#{hour - 12}:#{minute}pm"
  else
    "#{hour}:#{minute}am"

buildMessage = (msg, event, times, location) ->
  response = [ "The Comida Taco Truck's #{event} is '#{location['title']}'" ]

  if location['allDay']
    response.push "They will be there all day."
  else
    start = times[0]
    end = times[1]
    startTime = timeDuration(start)
    endTime = timeDuration(end)

    months = [ "January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December" ]

    day = start.getDate()
    month = months[start.getMonth()]

    response.push "They will be there on #{month} #{day} from #{startTime} to #{endTime}."

  msg.send response.join("\n")
  setTimeout (->
    msg.send location['url']
  ), 2000



