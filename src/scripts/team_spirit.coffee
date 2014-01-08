# Description
#   Smith has team spirit.
#
# Commands:
#   [ can i get | gimme | give me ] a[n] [phrase] on 3

module.exports = (robot) ->

  exports.spiritCount = []
  exports.spiritShout = ''

  robot.hear /([123])/, (msg) ->
    if exports.spiritCount.length > 0
      exports.spiritCount = exports.spiritCount.filter (s) -> s != msg.match[1]

      if exports.spiritCount.length == 0 && exports.spiritShout != ''
        message = exports.spiritShout.toUpperCase() + '!!!'
        exports.spiritCount = []
        exports.spiritShout = ''

        msg.send message

  robot.hear /(can i get|gimme|give me) an? (.+) on 3/i, (msg) ->

    exports.spiritCount = ['1', '2', '3']
    exports.spiritShout = msg.match[2]

    setTimeout (->
      if exports.spiritCount.length > 0
        exports.spiritCount = []
        exports.spiritShout = ''
    ), 15000

