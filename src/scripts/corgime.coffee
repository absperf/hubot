# Description:
#   CorgiMe is the most important thing in your life
#
# Commands:
#   hubot corgi me - Receive a corgi

module.exports = (robot) ->
  corgis = [
    'http://24.media.tumblr.com/tumblr_m8w267hQ7V1rvilzwo1_500.jpg',
    'http://24.media.tumblr.com/tumblr_mcp2lt385f1qg4kaco1_400.gif',
    'http://25.media.tumblr.com/tumblr_mbmj53ly1J1qk61m3o1_500.gif',
    'http://25.media.tumblr.com/tumblr_mb0g7rCf7c1qk61m3o1_500.gif',
    'http://24.media.tumblr.com/tumblr_m9sxb4rfjI1r7ktr7o1_250.gif',
    'http://25.media.tumblr.com/tumblr_m8xeu5uj371rzfamao1_400.gif',
    'http://25.media.tumblr.com/tumblr_m02kwhPVyH1qgrs58o1_400.gif',
    'http://media.tumblr.com/tumblr_m5dv1aFX931qhmds6.gif',
    'http://25.media.tumblr.com/tumblr_mayuzhhoVK1qiwf8po1_500.gif',
    'http://25.media.tumblr.com/tumblr_mb1lbcg20g1r6xrn3o1_500.gif',
    'http://25.media.tumblr.com/tumblr_mapa9pKb4s1qj7fh1o1_250.gif',
    'http://25.media.tumblr.com/tumblr_m8f4f0Qjjz1qiwf8po1_500.jpg',
    'http://25.media.tumblr.com/tumblr_m88olkJ1gj1qbwakso1_500.jpg',
    'http://25.media.tumblr.com/tumblr_m8wqnssMN41qd5j5io1_500.jpg',
    'http://24.media.tumblr.com/tumblr_m8f4cq84IL1qiwf8po1_500.jpg',
    'http://25.media.tumblr.com/tumblr_m8jwu2jywV1qkajelo1_500.gif',
    'http://25.media.tumblr.com/tumblr_m6psy25inb1qixk4mo1_r1_500.gif',
    'http://24.media.tumblr.com/tumblr_m8wl02zJBY1rdi0uro1_250.gif',
    'http://25.media.tumblr.com/tumblr_m8wl3qlLID1qmnzt5o1_500.jpg',
    'http://24.media.tumblr.com/tumblr_m8wkkxsMtd1rdi0uro1_500.gif',
    'http://i.imgur.com/1j7hjB5.gif'
  ]

  robot.respond /corgi me/i, (msg) ->
    msg.send corgis[Math.floor(Math.random()*corgis.length)]

  robot.respond /corgi bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    msg.send corgi for corgi in corgis

  robot.respond /how many corgis are there/i, (msg) ->
    msg.send "There are #{corgis.length} corgis."
