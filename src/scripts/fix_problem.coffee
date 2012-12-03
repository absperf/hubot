# Description:
#   Fix a problem
#
# Commands:
#   hubot fix [problem]

module.exports = (robot) ->
  robot.respond /fix (.+)/i, (msg) ->
    target = msg.match[1]
    msg.send("Okay. Trying to fix #{target}.")

    fixes = [
      'The problem was memcachd.',
      'It just needed to be restarted.',
      'Adam broke it before he left.',
      "I cherry picked a few random commits from a couple years ago."
    ]

    fix = fixes[Math.floor(Math.random() * fixes.length)]

    setTimeout (-> msg.send "Okay, #{target} has been fixed. #{fix}"), 10000


