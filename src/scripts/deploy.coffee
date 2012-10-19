# Deploying to ops
#
# Commands:
#   hubot [ship|deploy] [target] Deploys SystemShepherd to target node.

spawn = require('child_process').spawn
Sudo = require('./sudo')

module.exports = (robot) ->
  sudo = new Sudo(robot)

  sudo.respond /(ship|deploy) (.*)/i, (msg) ->
    target = msg.match[2]
    if targetList[target]?
      deploy msg, target
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

  hostList =
    'ops-db01': '172.18.0.121'
    'ops-proc01': '172.18.0.131'
    'ops-proc02': '172.18.0.132'
    'ssint2-proc01': '172.18.0.31'
    'ssint2-proc02': '172.18.0.32'
    'ssint2-proc03': '172.18.0.33'
    'ssint2-proc04': '172.18.0.34'
    'ssint2-proc05': '172.18.0.35'
    'ssint2-proc06': '172.18.0.36'
    'ssint2-db01': '172.18.0.13'
    'ssint2-db02': '172.18.0.17'
    'ssint2-db03': '172.18.0.19'
    'ssint2-db04': '172.18.0.24'
    'qapp06-proc01': '172.17.10.18'
    'qapp06-proc02': '172.17.10.19'
    'qapp06-db01':   '172.17.10.16'
    'qapp06-db02':   '172.17.10.22'
    'qapp06-db03':   '172.17.10.11'
    'aj-db01':     '192.168.31.21'
    'aj-proc01':  '192.168.31.31'
    'aj-poll01':   '192.168.31.51'

  targetList =
    'ops-proc01': ['ops-proc01']
    'ops-proc02': ['ops-proc02']
    'ops-procs': ['ops-proc01', 'ops-proc02']
    'ops-db01': ['ops-db01']
    'ops-dbs': ['ops-db01']
    'ops': ['ops-db01', 'ops-proc01', 'ops-proc02']
    'ssint2-proc01': ['ssint2-proc01']
    'ssint2-proc02': ['ssint2-proc02']
    'ssint2-proc03': ['ssint2-proc03']
    'ssint2-proc04': ['ssint2-proc04']
    'ssint2-proc05': ['ssint2-proc05']
    'ssint2-proc06': ['ssint2-proc06']
    'ssint2-procs': ['ssint2-proc01', 'ssint2-proc02', 'ssint2-proc03', 'ssint2-proc04', 'ssint2-proc05', 'ssint2-proc06']
    'ssint2-db01': ['ssint2-db01']
    'ssint2-db02': ['ssint2-db02']
    'ssint2-db03': ['ssint2-db03']
    'ssint2-db04': ['ssint2-db04']
    'ssint2-dbs': ['ssint2-db01', 'ssint2-db02', 'ssint2-db03', 'ssint2-db04']
    'ssint2': ['ssint2-db01', 'ssint2-db02', 'ssint2-db03', 'ssint2-db04', 'ssint2-proc01', 'ssint2-proc02', 'ssint2-proc03', 'ssint2-proc04', 'ssint2-proc05', 'ssint2-proc06']
    'qapp06-proc01': ['qapp06-proc01']
    'qapp06-proc02': ['qapp06-proc02']
    'qapp06-procs': ['qapp06-proc01', 'qapp06-proc02']
    'qapp06-db01': ['qapp06-db01']
    'qapp06-db02': ['qapp06-db02']
    'qapp06-db03': ['qapp06-db03']
    'qapp06-dbs': ['qapp06-db01', 'qapp06-db02', 'qapp06-db03' ]
    'qapp06': ['qapp06-db01', 'qapp06-db02', 'qapp06-db03', 'qapp06-proc01', 'qapp06-proc02' ]
    'aj-proc01': ['aj-proc01']
    'aj-procs': ['aj-proc01']
    'aj-db01': ['aj-db01']
    'aj-dbs': ['ajdb01']
    'aj': ['aj-db01', 'aj-proc01']

