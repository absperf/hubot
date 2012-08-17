# Description:
#   CorgiMe is the most important thing in your life
#
# Commands:
#   hubot corgi me - Receive a corgi

module.exports = (robot) ->
  corgis = [
    'http://24.media.tumblr.com/tumblr_m8w267hQ7V1rvilzwo1_500.jpg',
    'http://25.media.tumblr.com/tumblr_m8f4f0Qjjz1qiwf8po1_500.jpg',
    'http://25.media.tumblr.com/tumblr_m88olkJ1gj1qbwakso1_500.jpg',
    'http://25.media.tumblr.com/tumblr_m8wqnssMN41qd5j5io1_500.jpg',
    'http://24.media.tumblr.com/tumblr_m8f4cq84IL1qiwf8po1_500.jpg',
  ]

  robot.respond /corgi me/i, (msg) ->
    msg.send corgis[Math.floor(Math.random()*corgis.length)]

  robot.respond /corgi bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    msg.send corgi for corgi in corgis

  robot.respond /how many corgis are there/i, (msg) ->
    msg.send "There are #{corgis.length} corgis."
