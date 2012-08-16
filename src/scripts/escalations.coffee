# Description:
#   A way to manage escalations in the System Shepherd backends.
#
# Commands:
#   hubot acknowledge escalation <escalation id> at <backend>
#   hubot close escalation <escalation id> at <backend>
#   hubot suspend escalation <escalation id> at <backend> for <time>

module.exports = (robot) ->
  robot.respond /(ack|acknowledge)( esc(alation)?)? (\d+)( (at|on))? (.+)/i, (msg) ->
    stateChange = { _type: 'StateChange', escalation_id: msg.match[4], escalation_state_id: '3', suspend_pretty_interval: '', change_notes: '' }
    changeEscalationState msg, stateChange, msg.match[7]

  robot.respond /(susp|suspend)( esc(alation)?)? (\d+)( (at|on))? (.+)( for)? (.*)/i, (msg) ->
    stateChange = { _type: 'StateChange', escalation_id: msg.match[4], escalation_state_id: '4', suspend_pretty_interval: msg.match[7], change_notes: '' }
    changeEscalationState msg, stateChange, msg.match[7]

  robot.respond /(close)( esc(alation)?)? (\d+)( (at|on))? (.+)/i, (msg) ->
    stateChange = { _type: 'StateChange', escalation_id: msg.match[4], escalation_state_id: '5', suspend_pretty_interval: '', change_notes: '' }
    changeEscalationState msg, stateChange, msg.match[7]

changeEscalationState = (msg, stateChange, backend) ->
  backends =
    local: 'core.ssbe.localhost'
    localhost: 'core.ssbe.localhost'
    ops: 'core.ops.sysshep.com'

  credentials =
    'core.ssbe.localhost': 'dev:dev'
    'core.ops.sysshep.com': 'dev:dtdmnpp!!'

  baseUrl = backends[backend]

  msg.http("http://#{baseUrl}/service_descriptors")
    .header('accept', 'application/vnd.absperf.sskj1+json')
    .get() (err, res, body) ->
      getAlarmServiceDescriptors msg, JSON.parse(body), stateChange, credentials[baseUrl]

getAlarmServiceDescriptors = (msg, services, stateChange, credentials) ->
  for service in services.items
    if service.service_type == 'http://systemshepherd.com/services/escalations'
      msg.http(service.href)
        .header('accept', 'application/vnd.absperf.ssaj1+json')
        .get() (err, res, body) ->
          getAllEscalationsResourceDescriptor msg, JSON.parse(body), stateChange, credentials

getAllEscalationsResourceDescriptor = (msg, services, stateChange, credentials) ->
  for service in services.items
    if service.name == 'AllEscalations'
      msg.http("#{service.href}/#{stateChange.escalation_id}")
        .auth(credentials)
        .header('accept', 'application/vnd.absperf.ssaj1+json')
        .get() (err, res, body) ->
          createStateChange msg, JSON.parse(body), stateChange, credentials

createStateChange = (msg, escalation, stateChange, credentials) ->
  msg.http(escalation.state_changes_href)
    .auth(credentials)
    .header('accept', 'application/vnd.absperf.ssaj1+json')
    .header('content-type', 'application/vnd.absperf.ssaj1+json')
    .post(JSON.stringify(stateChange)) (err, res, body) ->
      if res.statusCode.toString().match /^20\d$/
        states = { '3': 'acknowledged', '4': 'suspended', '5': 'closed' }
        msg.send "Escalation #{stateChange.escalation_id} has been #{states[stateChange.escalation_state_id]}"
      else
        msg.send "Failed to change the status of escalation #{stateChange.escalation_id}, response was #{res.statusCode}"
