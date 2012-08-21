# Deploying to ops
#
# ship|deploy ops | ops-proc01 | ops-db01 - kicks off run-chef.sh on selected machine

spawn = require('child_process').spawn

module.exports = (robot) ->
  robot.respond /(ship|deploy) (.*)/i, (msg) ->
    deploy msg, msg.match[2]

host_list =
  'ops-db01': '172.18.0.121'
  'ops-proc01': '172.18.0.131'
  'ops-proc02': '172.18.0.132'

target_list =
  'ops-proc01': ['ops-proc01']
  'ops-proc02': ['ops-proc02']
  'ops-db01': ['ops-db01']
  'ops': ['ops-db01', 'ops-proc01', 'ops-proc02']

deploy = (msg, target) ->
  runchef = ""
  if target_list[target]?
    for host_name in target_list[target]
      host_address = host_list[host_name]
      runchef = spawn('ssh', ["#{process.env.ROUTER_USER}@#{process.env.ROUTER_IP}", "ssh #{process.env.DEPLOY_USER}@#{host_address} /home/ubuntu/run-chef.sh"])
      deploy_response(msg, runchef, host_name)
  else
    targets = for key, value of target_list
      key
    msg.send "Can only deploy on: #{targets.join(', ')}"

deploy_response = (msg, runchef, target) ->
  runchef.on("exit", (code) ->
    unless code == 0
      msg.send "There was an error deploying on #{target}: Code #{code}"
  )
