# Description:
#   Thanks, Obama!
#
# Commands:
#   hubot thanks obama - thank obama

module.exports = (robot) ->

  thanks = [
    "http://i.imgur.com/nKZciEY.gif",
    "http://i.minus.com/ibrr7LpmCwfKJm.gif",
    "http://imgur.com/GsSKEsk",
    "http://i.imgur.com/gvkx8hp.gif",
    "http://i.imgur.com/fJW8dnj.gif",
    "http://i.imgur.com/VrERIRo.gif",
    "http://i.imgur.com/mV6adpD.gif",
    "http://i.imgur.com/UoQKVA1.gif",
    "http://i.imgur.com/kIMrAal.gif",
    "http://i.imgur.com/ri2VluK.gif",
    "http://i.imgur.com/secUasl.gif",
    "http://i.imgur.com/5jq76.gif",
    "http://i.imgur.com/h1X0v.gif",
    "http://i.imgur.com/9B5F2.gif",
    "http://i.imgur.com/5Clgi.gif",
  ]

  robot.hear /thanks,?\s+obama/i, (msg) ->
    msg.send thanks[Math.floor(Math.random()*thanks.length)]

