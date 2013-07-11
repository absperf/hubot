# Description:
#   A Developer Surrogate Plugin
#
module.exports = (robot) ->

  fixes = [
    'The problem was memcached.',
    'It just needed to be restarted.',
    'Adam broke it before he left.',
    'Joanne broke it before she left.',
    'I cherry picked a few random commits from a couple years ago.',
    'The CPU fluid was out.',
    'Quit using IE.',
    'It was due to a faulty steering actuator.',
    'The unicorn was on the loose again.',
    'It is now version 2.0.',
    'It is now a feature.',
    'The problem was PC Load Letter.',
    'I armbarred it into submission',
    'I pressed the on button',
    'I removed the tape from under the mouse.',
    'Write better code next time.',
    'There is no technical reason why that should not have worked.'
  ]

  ideas =
    bad: [
      "That isn't going to work.",
      "What a terrible idea.",
      "I don't think you thought that through.",
      "Your idea is terrible and you should feel terrible."
    ],
    good: [
      "That just might work.",
      "What a great idea!",
      "You are a genius.",
      "Make it so, number one."
    ]

  robot.respond /fix (.+)/i, (msg) ->
    target = msg.match[1]

    msg.send("Okay, I'll try fixing #{target}.")

    fix = fixes[Math.floor(Math.random() * fixes.length)]
    setTimeout (-> msg.send "Okay, #{target} has been fixed. #{fix}"), 5000

  robot.respond /(do you think)|(should we)/i, (msg) ->
    responses = ideas[Object.keys(ideas)[Math.floor(Math.random() * 2)]]

    msg.send responses[Math.floor(Math.random() * responses.length)]

