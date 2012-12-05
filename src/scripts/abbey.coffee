# Description:
#   Locate Abbey
#
# Commands:
#   hubot where is abbey

module.exports = (robot) ->
  robot.respond /(where is|find) abb(e)?y/i, (msg) ->
    locations = [
      "right behind you!",
      'at your house, going through your things.',
      'crying herself to sleep, thinking of you.',
      'rolling around in a pile of your hair, stolen from the barber.',
      'knocking on your door at 2AM.',
      'filling out a loan application in your name.',
      'telling your family members that you two are soul mates.',
      'creating a scrapbook of you with pictures taken while you were sleeping.',
      'eating the last person she stalked.'
    ]

    msg.send "She's #{locations[Math.floor(Math.random() * locations.length)]}"

