# Description:
#   Random project idea generator.
#
# Commands:
#   hubot project idea

module.exports = (robot) ->
  robot.respond /project\sidea/i, (msg) ->
    inventIdea(msg)

inventIdea = (msg) ->
  idea = []
  idea.push random(intros)
  idea.push 'web app like'
  idea.push random(projects)
  idea.push 'geared towards'
  idea.push random(types)
  idea.push random(targets)

  msg.send idea.join(" ")

random = (array) ->
  array[Math.floor(Math.random() * array.length)]

intros = [
  'How about a',
  'You should make a',
  "I've never seen a",
  'You know what would be great? A',
  'I think the market is ready for a'
]

projects = [
  'Facebook',
  'Tumblr',
  'LinkedIn',
  'YouTube',
  'Twitter',
  'Paypal',
  'EBay',
  'MySpace',
  'GitHub',
  'Yelp',
  'FourSquare',
  'Instagram',
  'Kickstarter',
  'SystemShepherd'
]

types = [
  'lazy',
  'hard working',
  'technically literate',
  'technically illiterate',
  'smart',
  'dumb',
  'deaf',
  'blind',
  'mute',
  'old',
  'young',
  'crazy'
]

targets = [
  'students.',
  'parents.',
  'programmers.',
  'writers.',
  'politicians.',
  'soldiers.',
  'astronauts.',
  'coal miners.',
  'waitresses.',
  'bakers.',
  'chefs.',
  'lawyers.',
  'pets.',
  'aliens.',
  'farmers.',
  'farm animals.'
]
