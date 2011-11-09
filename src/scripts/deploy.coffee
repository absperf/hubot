# Deploying to ops-proc01.
# 
# ship ops-proc01 - kicks off run-chef.sh 

spawn = require('child_process').spawn

module.exports = (robot) ->
  robot.respond /(ship) (.*)/i, (msg) ->
    deploy msg, msg.match[2]

node_list = ['ops-proc01']

deploy = (msg, target) ->
  runchef = ""
  if target == node_list[0]
    runchef = spawn '/home/ubuntu/run-chef.sh'
    deploy_response(msg, runchef)
  else
    msg.send "Can only deploy on: ${node_list.join(', ')}"

deploy_response = (msg, runchef) ->
  msg.send "Running chef deploy for #{target}... "
  runchef.on("exit", (code) ->
    if code == 0
      msg.send "Finished deploying on #{target} successfully."
    else 
      msg.send "There was an error deploying on #{target}."
  )
