# Description
#   Smith has team spirit.
#
# Commands:
#   [ can i get | gimme | give me ] a[n] [phrase] on 3

module.exports = (robot) ->

  robot.hear /(can i get|gimme|give me) an? (.+) on 3/i, (msg) ->
    for i in [1, 2, 3]
      setTimeout (-> msg.send i.toString()), (i + 1) * 1000
    setTimeout (-> msg.send msg.match[2].toUpperCase() + '!!!'), 6000

