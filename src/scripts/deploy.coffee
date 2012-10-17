# Deploying to ops
#
# Commands:
#   hubot ship|deploy ops | ops-proc01 | ops-db01 - kicks off run-chef.sh on selected machine

spawn = require('child_process').spawn

exports.deploy_password = {}

sudoers = ['Gino', 'Adam', 'Joanne', 'Erik', 'Shell']
unprotected = ['ops-proc01', 'ops-db01']
# unprotected = ['ops-proc01', 'ops-proc02', 'ops-db01']

hostList =
  'ops-db01': '172.18.0.121'
  'ops-proc01': '172.18.0.131'
  'ops-proc02': '172.18.0.132'

targetList =
  'ops-proc01': ['ops-proc01']
  'ops-proc02': ['ops-proc02']
  'ops-db01': ['ops-db01']
  'ops': ['ops-db01', 'ops-proc01', 'ops-proc02']

initPassword = (time, passwordHash = {})->
  exports.deploy_password = passwordHash
  setTimeout (-> exports.deploy_password = {}), time

generatePassword = (target) ->
  alphanum = 'abcdefghijklmnopqrstuvwxyz0123456789'.split('')
  alphanum = alphanum.sort(-> Math.floor(Math.random() * alphanum.length))
  password = alphanum.reverse().join('').match(/\D.+$/)[0][0..7]

  passwordHash = {}
  passwordHash[password] = target
  initPassword 20000, passwordHash
  password

module.exports = (robot) ->

  robot.hear /(.+)/, (msg) ->
    name = msg.message.user.name.split(' ')
    name = name[0]
    target = exports.deploy_password[msg.match[0]]

    if target && name in sudoers
      initPassword 0
      deploy msg, target

  robot.respond /(sudo )?(ship|deploy) (.*)/i, (msg) ->
    name = msg.message.user.name.split(' ')
    name = name[0]

    target = msg.match[3]

    if targetList[target]?
      if target in unprotected
        deploy msg, target

      else if msg.match[1]
        if name in sudoers
          msg.send "Please enter the generated password to deploy to #{target}."
          msg.send "This password will expire in 20 seconds:  #{generatePassword(target)}"
        else
          msg.send "You don't have permission to deploy to protected SystemShepherd nodes."
      else
        msg.send "This is a protected deploy target, please use sudo."
    else
      targets = for key, value of targetList
        key
      msg.send "That is not a valid deploy target. (#{targets.join(', ')})"

deploy = (msg, target) ->
  runchef = ""
  for hostName in targetList[target]
    hostAddress = hostList[hostName]
    runchef = spawn('ssh', ['-o', 'StrictHostKeyChecking=no', "#{process.env.ROUTER_USER}@#{process.env.ROUTER_IP}", 'ssh', '-o', 'StrictHostKeyChecking=no', "#{process.env.DEPLOY_USER}@#{hostAddress}", "/home/ubuntu/run-chef.sh"])
    deploy_response(msg, runchef, hostName)

deploy_response = (msg, runchef, target) ->
  runchef.on "exit", (code) ->
    unless code == 0
      msg.send "There was an error deploying on #{target}: Code #{code}"
