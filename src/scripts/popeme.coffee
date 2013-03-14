# Description
#   The blessed plugin of API.
#
# Commands:
#   smith pope me
#   smith what is pope?
#   smith what even is a pope?

module.exports = (robot) ->

  robot.respond /pope me/i, (msg) ->
    msg.message.text = "smith mustache me pope"
    robot.receive msg.message
    msg['message']['done'] = true

  robot.respond /what( even)? is( a)? pope\?/i, (msg) ->
    popes = ['bascially human god',
             'great warrior',
             'groundhog',
             'animal from jungle',
             'comrade in arms',
             'brother from another mother',
             'old man with big hat',
             'man who wear dress and jewelry',
             'strong like bull']

    msg.send 'pope is ' + popes[Math.floor(Math.random() * popes.length)]

