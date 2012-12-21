# Description:
#   NinjaMe is the most important thing in Tim's life
#
# Commands:
#   hubot ninja me - Receive a ninja

module.exports = (robot) ->

  ninjas = [
    'http://4.bp.blogspot.com/-XCvUVP29R2o/UD2O4W4rdKI/AAAAAAAAAF0/1oiWxzNhEII/s1600/ninja.jpg.jpg',
    'http://www.ninjastars.org/wp-content/uploads/2011/07/Ninja1.jpg',
    'http://www.skullninja.com/images/sprites/ninja.png',
    'http://sowhatfaith.com/wp-content/uploads/2012/10/ninjas.gif',
    'http://game-server-hosting.net/wp-content/uploads/2008/12/Ninja%20Blade%20-%204.jpg',
    'http://images.halloweencostumes.com/adult-deluxe-ninja-costume-zoom.jpg',
    'http://www.weapons-universe.com/Martial_Arts/Ninja/Ninja-Sho_Kosugi-02.jpg',
    'http://cdnext.seomoz.org/1334096631_524af3459828cf29b4cfcfacbcf2f1e7.jpg',
    'http://3.bp.blogspot.com/-QDI9BNZLizQ/UEmYO7PMUgI/AAAAAAAAFJA/nmgwcdrNmKU/s1600/ninja_crouch.jpg',
    'http://levelselect.co.uk/wp-content/uploads/2008/07/wee_ninja.jpg',
    'http://images.halloweencostumes.com/ninja-master-costume-zoom.jpg',
    'http://chico-ui.com.ar/src/assets/ninja.png',
    'http://images.halloweencostumes.com/black-child-ninja-costume-zoom.jpg',
    'http://www.martialartsone.co.uk/images/ninjablack-lge.jpg',
    'http://www.theresumator.com/blog_assets/2012/08/ninja_horiz-e1345560290768-500x246.jpg',
    'http://sarxos.files.wordpress.com/2009/10/ninja_turtles.jpg',
  ]

  robot.respond /ninja me/i, (msg) ->
    msg.send ninjas[Math.floor(Math.random()*ninjas.length)]

  robot.respond /ninja bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    msg.send ninja for ninja in ninjas

  robot.respond /how many ninjas are there/i, (msg) ->
    msg.send "There are #{ninjas.length} ninjas."
