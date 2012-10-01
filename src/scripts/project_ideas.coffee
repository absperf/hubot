# Description:
#   Random project idea generator.
#
# Commands:
#   hubot project idea
#   hubot i need a project idea
#   hubot give me a project idea

module.exports = (robot) ->
  robot.respond /^(.+\s)?project\sidea(\s.+)?$/i, (msg) ->
    inventIdea(message) -> msg.send message

inventIdea = (message) ->
  idea = []
  idea << random(intros)
  idea << 'web app like'
  idea << random(projects)
  idea << 'geared towards'
  idea << random(types)
  idea << random(targets)
  idea << '.'

  message idea

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
  'students',
  'parents',
  'programmers',
  'writers',
  'politicians',
  'soldiers',
  'astronauts',
  'coal miners',
  'waitresses',
  'bakers',
  'chefs',
  'lawyers',
  'pets',
  'aliens',
  'farmers',
  'farm animals'
]
