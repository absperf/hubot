# Description:
#   Allows Hubot to send text messages using Twilio API
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_SMS_SID
#   HUBOT_SMS_TOKEN
#   HUBOT_SMS_FROM
#
# Commands:
#   hubot text [to] this: [message] - Sends [message] to the user [to]
#   hubot set phone number for [name] to [number]
#
# Author:
#   caleywoods
#   trinary

QS = require "querystring"

module.exports = (robot) ->
  robot.respond /set phone number for @?([\w .-_]+) to (.+)/, (msg) ->
    name = msg.match[1].trim()
    users = robot.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      user.phone = msg.match[2].trim()
      user.save
      msg.send "ok, set #{name}'s phone number to #{user.phone}"
    else if users.length > 1
      msg.send "name matches more than one person"
    else
      msg.send "I don't know who that is."

  robot.respond /text @?([\w .-_]+)? this:\s*(.*)/i, (msg) ->
    to    = msg.match[1]
    bahdy = msg.match[2] # bahdy, that's how john mayer would say it.
    sid   = process.env.HUBOT_SMS_SID
    tkn   = process.env.HUBOT_SMS_TOKEN
    from  = process.env.HUBOT_SMS_FROM

    unless sid
      msg.send "Twilio SID isn't set."
      msg.send "Please set the HUBOT_SMS_SID environment variable."
      return

    unless tkn
      msg.send "Twilio token isn't set."
      msg.send "Please set the HUBOT_SMS_TOKEN environment variable."
      return

    unless from
      msg.send "Twilio from number isn't set."
      msg.send "Please set the HUBOT_SMS_FROM environment variable."
      return

    users = robot.usersForFuzzyName(to)
    if users.length is 1
      user = users[0]
      number = user.phone
      auth  = 'Basic ' + new Buffer(sid + ':' + tkn).toString("base64")
      data  = QS.stringify From: from, To: number, Body: bahdy


      msg.http("https://api.twilio.com")
        .path("/2010-04-01/Accounts/#{sid}/SMS/Messages.json")
        .header("Authorization", auth)
        .header("Content-Type", "application/x-www-form-urlencoded")
        .post(data) (err, res, body) ->
          json = JSON.parse body
          switch res.statusCode
            when 201
              msg.send "Sent sms to #{to}"
            when 400
              msg.send "Failed to send. #{json.message}"
            else
              msg.send "Failed to send."
    else if users.length > 1
      msg.send "Be more specific, I know #{users.length} people named like that: #{user.name for user in users.join(',')}"
    else
      msg.send "I don't know who that is"

