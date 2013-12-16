# Description:
#   The CSTeam Rules
#
# Commands:
#   hubot (what are the )csteam rules

module.exports = (robot) ->

  rules = [
    '1. No one likes you.',
    '2. No one likes you.',
    '3. Get back to work.',
    '4. Just because it’s 2 am, doesn’t mean you get to sleep.',
    '5. You must be working no less than 3 issues at a time.',
    '6. No breaks, no lunch.',
    '7. On-call will go on as long as it has to.',
    '8. If this is your first week at API, you HAVE to be on-call.',
    '9. All issues should only take 15 mins to resolve.',
    '10. "What!? Are you retarded?"',
    '11. Do something, even if it’s wrong.',
    '12. "This ain’t the Girl Scouts."',
  ]

  robot.respond /(what are the )?csteam rules/i, (msg) ->
    msg.send rules.join("\n")
