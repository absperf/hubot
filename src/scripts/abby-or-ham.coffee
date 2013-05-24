# Description:
#   Locate Abby or Ham
#
# Commands:
#   hubot where is [abby|ham]

module.exports = (robot) ->
  robot.respond /(where is|find) (abby|ham)/i, (msg) ->
    locations = [
      "right behind you!",
      'at your house, going through your things.',
      'crying herself to sleep, thinking of you.',
      'rolling around in a pile of your hair that she stole from the barber.',
      'knocking on your door at 2AM.',
      'filling out a loan application in your name.',
      'telling your family members that you two are soul mates.',
      'creating a scrapbook of you with pictures taken while you were sleeping.',
      'brushing her teeth with your toothbrush.',
      'at the courthouse, changing her last name to yours.',
      'eating the last person she stalked.',
      'carving your name into her arm.',
      'keeping a journal of your daily activities.',
      "trying to figure out the best way to turn you inside out.",
      'waiting for you in the back seat of your car.',
      'going through your trash.',
      'counting the seconds until you two can be together... FOREVER.'
    ]

    person = "He"
    person = "She" if msg.match[2].match /abby/i

    msg.send "#{person}'s #{locations[Math.floor(Math.random() * locations.length)]}"

