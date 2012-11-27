# Description:
#   Flip the table
#
# Commands:
#   hubot flip the table

module.exports = (robot) ->
  robot.respond /flip( the table| table)?/i, (msg) ->
    msg.send('(╯°□°）╯︵ ┻━┻')

    setTimeout (-> msg.send '┬─┬ノ(º_ºノ)'), 10000

