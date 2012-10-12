# Description
#   Ask Smith to attack someone with a hand seal.
#   Also, attack Tim every time he enters a room.
#
# Commands:
#   hubot [kill|destroy|attack] [name]


imgur = 'http://api.imgur.com/2/upload.json'
dir = '/home/ubuntu/seals'

spawn = require('child_process').spawn

module.exports = (robot) ->
  robot.respond /(kill|destroy|attack) (.+)/i, (msg) ->
    numberOfSeals = Math.floor(Math.random() * 3) + 3 # minimum 3, max 6
    createJutsu msg, numberOfSeals, (message) -> msg.send message

createJutsu = (msg, numberOfSeals, message) ->
  jutsu = []
  output = []
  post = []

  until jutsu.length >= numberOfSeals
    name = seals[Math.floor(Math.random() * 12)]
    file = "#{dir}/#{name}.gif"
    jutsu.push name: name, file: file


  command = ["gm convert -loop 100"]
  for seal in jutsu
    command.push "-delay 100 #{seal.file}"
  command.push "-delay 10 #{dir}/fight_#{Math.floor(Math.random() * 8) + 1}.gif"
  command.push "/tmp/jutsu.gif"

  gm = spawn('sh', ['-c', command.join(' ')])
  gm.stdout.on 'data', (data) -> output.push(data)
  gm.stderr.on 'data', (data) -> output.push(data)
  gm.on 'exit', (code) ->
    if code == 0
      command = ["curl -F \'image=@/tmp/jutsu.gif\'"]
      command.push "-F \'key=#{process.env.IMGUR_KEY}\'"
      command.push imgur

      upload = spawn('sh', ['-c', command.join(' ')])
      upload.stdout.on 'data', (data) -> post.push(JSON.parse(data))
      upload.stderr.on 'data', (data) -> output.push(data)
      upload.on 'exit', (code) ->
        if code == 0
          msg.send (sealNames[seal.name] for seal in jutsu).join(' ')
          msg.send post[0].upload.links.original
        else
          msg.send output.join(' ')
          msg.send "There was a problem posting the jutsu."
    else
      msg.send output.join(' ')
      msg.send "There was a problem building the jutsu."

sealNames =
  rat: 'Ne'
  ox: 'Ushi'
  tiger: 'Tora'
  rabbit: 'U'
  dragon: 'Tatsu'
  snake: 'Mi'
  horse: 'Uma'
  ram: 'Hitsuji'
  monkey: 'Saru'
  bird: 'Tori'
  dog: 'Inu'
  boar: 'I'

seals = [
  'rat',
  'ox',
  'tiger',
  'rabbit',
  'dragon',
  'snake',
  'horse',
  'ram',
  'monkey',
  'bird',
  'dog',
  'boar' ]

