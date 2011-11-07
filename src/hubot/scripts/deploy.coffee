# Deploying...
#            
module.exports = (robot) ->
  robot.respond /(ship) (.*)/i, (msg) ->
    deploy msg.match[2], (stderr, stdout, error) ->
      msg.send stdout

node_list = ['ops-proc01', 'ops-db01']

deploy = (target) ->
  if target == node_list[0]
    _ref '/home/ubuntu/run-chef.sh'
