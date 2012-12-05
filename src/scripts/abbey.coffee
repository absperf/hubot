# Description:
#   Locate Abbey
#
# Commands:
#   hubot where is abbey

module.exports = (robot) ->
  robot.respond /(where is|find) abbey/i, (msg) ->
    locations = [
      "I can't find her... stay alert!",
      "Right behind you!",
      'At your house, going through your things.',
      'Crying herself to sleep, thinking of you.',
      'Rolling around in a pile of your hair, stolen from the barber.',
      'Knocking on your door at 2AM.',
      'Filling out a loan application in your name.',
      'Telling your family members that you two are soul mates.',
      'Creating a scrapbook of you with pictures taken while you were sleeping.',
      'Eating the last person she stalked.'
    ]

    msg.send locations[Math.floor(Math.random() * locations.length)]

