# Description:
#   HighFive me is the most important thing in your life.
#
# Commands:
#   hubot high five me - receive a high five
#

module.exports = (robot) ->
  highFives = [
    "http://www.wired.com/images/article/magazine/1607/st_howto_f.jpg#.png",
    "http://25.media.tumblr.com/tumblr_m9op265iw51qzhkvho1_500.gif",
    "http://25.media.tumblr.com/tumblr_md9s3w522z1ritteso1_500.gif",
    "http://data.whicdn.com/images/35767316/tumblr_m9b7e6NFii1qzwhb0o1_500_large.gif",
    "http://x2a.xanga.com/f4915bf133432276270747/z205099164.gif",
    "(＾∇＾)/\\(＾∇＾)"
  ]

  robot.respond /high five (.+)/i, (msg) ->
    msg.send highFives[Math.floor(Math.random()*highFives.length)]
