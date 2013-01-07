# Description:
#   HighFive me is the most important thing in your life.
#
# Commands:
#   hubot high five me - receive a high five
#

module.exports = (robot) ->
  highFives = [
    "http://www.wired.com/images/article/magazine/1607/st_howto_f.jpg#.png",
    "(＾∇＾)/\(＾∇＾)"
  ]

  robot.respond /high five me/i, (msg) ->
    msg.send highFives[Math.floor(Math.random()*highFives.length)]
