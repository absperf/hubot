# Deploying to ops-proc01.
# 
# ship ops-proc01 | ops-db01 - kicks off run-chef.sh on selected machine 

spawn = require('child_process').spawn

module.exports = (robot) ->
  robot.respond /(ship) (.*)/i, (msg) ->
    deploy msg, msg.match[2]

#Desperately need to refactor
node_list = ['ops-proc01', 'ops-db01']

deploy = (msg, target) ->
  runchef = ""
  if target == node_list[0]
    runchef = spawn('ssh', ['ubuntu@172.18.0.121', '/home/ubuntu/run-chef.sh'])
    deploy_response(msg, runchef, target)
  else if target == node_list[1]
    runchef = spawn('ssh', ['ubuntu@172.18.0.131', '/home/ubuntu/run-chef.sh'])
    deploy_response(msg, runchef, target)
  else
    msg.send "Can only deploy on: #{node_list.join(', ')}"

deploy_response = (msg, runchef, target) ->
  msg.send "Running chef deploy for #{target}... "
  runchef.on("exit", (code) ->
    if code == 0
      msg.send "Finished deploying on #{target}."
    else
      msg.send "There was an error deploying on #{target}: Code #{code}"
  )