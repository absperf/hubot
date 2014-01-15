# Description
#   Smith has team spirit.
#
# Commands:
#   [ can i get | gimme | give me ] a[n] [phrase] on 3

module.exports = (robot) ->

  robot.hear /(can i get|gimme|give me) an? (.+) on 3/i, (msg) ->

    setTimeout (-> msg.send '1'), 2000
    setTimeout (-> msg.send '2'), 4000
    setTimeout (-> msg.send '3'), 6000
    setTimeout (-> msg.send spiritShout.toUpperCase() + '!!!'), 10000
