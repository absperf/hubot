# Description:
#   Fix a problem
#
# Commands:
#   hubot fix [problem]

module.exports = (robot) ->
  robot.respond /fix (.+)/i, (msg) ->
    target = msg.match[1]
    msg.send("Trying to fix #{target}.")

    fixes = [
      'The problem was memcached.',
      'It just needed to be restarted.',
      'Adam broke it before he left.',
      'I cherry picked a few random commits from a couple years ago.',
      'The CPU fluid was out.'
      'Quit using IE.'
      'It was due to a faulty steering actuator.'
      'The unicorn was on the loose again.'
      'Googled it.'
      'It is now version 2.0.'
      'It is now a feature.'
      'The problem was PC Load Letter.'
      'Armbarred it into submission'
      'Pressed the on button'
      'Removed the tape from under the mouse'
      'Write better code next time'
      'There is no technical reason why that should not have worked.'
    ]

    fix = fixes[Math.floor(Math.random() * fixes.length)]

    setTimeout (-> msg.send "Okay, #{target} has been fixed. #{fix}"), 10000


