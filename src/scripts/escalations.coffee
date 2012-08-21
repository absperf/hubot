# Description:
#   A way to list and manage escalations in the System Shepherd backends.
#
# Commands:
#   hubot acknowledge escalation <escalation id> at <backend>
#   hubot close escalation <escalation id> at <backend>
#   hubot suspend escalation <escalation id> at <backend> for <time>
#   hubot list <all, open, ack(nowleged), susp(ended), crit(icals), warn(ings)> at <backend>
#   hubot view <escalation id> at <backend>

module.exports = (robot) ->
  robot.respond /(list) (open|ack|susp|all|crit|warn)(\w+)? (at|on|from|for)? (.+)/i, (msg) ->
    listOpenEscalations msg, msg.match[2], msg.match[5], (message) -> msg.send message

  robot.respond /(view) (\d+) (at|on|from|for)? (.+)/i, (msg) ->
    viewEscalation msg, msg.match[2], msg.match[4], (message) -> msg.send message

  robot.respond /(ack|acknowledge)( esc(alation)?)? (\d+)( (at|on))? (.+)/i, (msg) ->
    stateChange = { _type: 'StateChange', escalation_id: msg.match[4], escalation_state_id: '3', suspend_pretty_interval: '', change_notes: '' }
    changeEscalationState msg, stateChange, msg.match[7], (message) -> msg.send message

  robot.respond /(susp|suspend)( esc(alation)?)? (\d+)( (at|on))? (.+)( for)? (.*)/i, (msg) ->
    stateChange = { _type: 'StateChange', escalation_id: msg.match[4], escalation_state_id: '4', suspend_pretty_interval: msg.match[7], change_notes: '' }
    changeEscalationState msg, stateChange, msg.match[7], (message) -> msg.send message

  robot.respond /(close)( esc(alation)?)? (\d+)( (at|on))? (.+)/i, (msg) ->
    stateChange = { _type: 'StateChange', escalation_id: msg.match[4], escalation_state_id: '5', suspend_pretty_interval: '', change_notes: '' }
    changeEscalationState msg, stateChange, msg.match[7], (message) -> msg.send message

mime = [ "application/vnd.absperf.ss#{v}j1+json" for v in "amk" ].join(', ')

backendList =
  local: 'core.ssbe.localhost'
  localhost: 'core.ssbe.localhost'
  ops: 'core.ops.sysshep.com'
  ssint2: 'core.ss-internal2.den.sysshep.com'
  ssbe06: 'core.ssbe06.qwest.sysshep.com'

credentialsList =
  'core.ssbe.localhost': process.env.DEFAULT_CREDENTIALS
  'core.ops.sysshep.com': process.env.STANDARD_CREDENTIALS
  'core.ss-internal2.den.sysshep.com': process.env.STANDARD_CREDENTIALS
  'core.ssbe06.qwest.sysshep.com': process.env.STANDARD_CREDENTIALS

viewEscalation = (msg, escalation, backend, message) ->
  baseUrl = backendList[backend]
  credentials = credentialsList[baseUrl]

  getAlarmServiceDescriptors msg, backend, baseUrl, (escalations) ->
    msg.http("#{escalations.href}/#{escalation}")
      .auth(credentials)
      .header('accept', mime)
      .get() (err, res, body) ->
        alert = JSON.parse(body)

        response = [
          "Escalation ##{escalation}",
          alert.href,
          "Current State: #{alert.current_state}",
          "Current Status: #{alert.current_status}"
        ]

        msg.http(alert.messages_href)
           .auth(credentials)
           .header('accept', mime)
           .get() (err, res, body) ->
             last = JSON.parse(body).items[0]
             response.push "Last message recieved: #{last.message}"

             metric_hrefs = alert.affected_metric_hrefs
             count = 0

             alerting = [ "Alerting metrics:" ]
             for metric_href in metric_hrefs
               msg.http(metric_href)
                  .auth(credentials)
                  .header('accept', mime)
                  .get() (err, res, body) ->
                    alerting.push JSON.parse(body).name

                    count += 1
                    if (count + 1) == metric_hrefs.length
                      response.push alerting.join(' ')
                      message response.join("\n")

listOpenEscalations = (msg, type, backend, message) ->
  baseUrl = backendList[backend]
  credentials = credentialsList[baseUrl]

  getAlarmServiceDescriptors msg, backend, baseUrl, (escalations) ->
    msg.http(escalations.href)
      .auth(credentials)
      .header('accept', mime)
      .get() (err, res, body) ->

        items = JSON.parse(body).items
        response = [ "Escalation ID: "]
        count = 0

        for item in items
          msg.http(item.href)
            .auth(credentials)
            .header('accept', mime)
            .get() (err, res, body) ->
              alert = JSON.parse(body)
              types = RegExp(alert.current_status + "|all|" + alert.current_state)

              id = /.+escalations\/(\d+)/
              response.push alert.href.match(id)[1] if type.match(types)
              count += 1

              if (count + 1) == items.length
                message response.join("\n")

changeEscalationState = (msg, stateChange, backend, message) ->
  baseUrl = backendList[backend]
  credentials = credentialsList[baseUrl]

  getAlarmServiceDescriptors msg, backend, baseUrl, (escalations) ->
    msg.http("#{escalations.href}/#{stateChange.escalation_id}")
      .auth(credentials)
      .header('accept', mime)
      .get() (err, res, body) ->
        createStateChange msg, JSON.parse(body), stateChange, credentials, message

getAlarmServiceDescriptors = (msg, backend, baseUrl, escalations) ->
  msg.http("http://#{baseUrl}/service_descriptors")
    .header('accept', mime)
    .get() (err, res, body) ->
      getEscalationsResourceDescriptor msg, JSON.parse(body), escalations

getEscalationsResourceDescriptor = (msg, services, escalations) ->
  for service in services.items
    if service.service_type == 'http://systemshepherd.com/services/escalations'
      msg.http(service.href)
        .header('accept', mime)
        .get() (err, res, body) ->
          getAllEscalationsResourceDescriptor msg, JSON.parse(body), escalations

getAllEscalationsResourceDescriptor = (msg, services, escalations) ->
  for service in services.items
    if service.name == 'AllEscalations'
      escalations service

createStateChange = (msg, escalation, stateChange, credentials, message) ->
  msg.http(escalation.state_changes_href)
    .auth(credentials)
    .header('accept', mime)
    .header('content-type', mime)
    .post(JSON.stringify(stateChange)) (err, res, body) ->
      if res.statusCode.toString().match /^20\d$/
        states = { '3': 'acknowledged', '4': 'suspended', '5': 'closed' }
        message "Escalation #{stateChange.escalation_id} has been #{states[stateChange.escalation_state_id]}"
      else
        message "Failed to change the status of escalation #{stateChange.escalation_id}, response was #{res.statusCode}"

