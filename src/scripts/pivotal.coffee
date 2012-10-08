# Description:
#   Get current stories from PivotalTracker
#
# Commands:
#   hubot show [done|current|backlog|current_backlog] stories - shows current stories being worked on
#   hubot add [bug|feature|chore] story
#   hubot pivotal user [pivotal user name]

Parser = require("xml2js").Parser

types = ['done', 'current', 'backlog', 'current_backlog']
token = process.env.HUBOT_PIVOTAL_TOKEN
projectId = process.env.HUBOT_PIVOTAL_PROJECT

findType = (match) ->
  if match? and match in types
    return match
  else
    return ""

sendStories = (msg, stories) ->
  storyStr = ""
  for story in stories.story
    storyStr += "#{story.story_type}: #{story.name} - #{story.current_state} by #{story.owned_by} (#{story.url})\n"
  msg.send storyStr

module.exports = (robot) ->
  robot.respond /show\s+(done|current|backlog|current_backlog)?(\s+)?stories/i, (msg) ->
    type = findType msg.match[1]
    parser = new Parser()

    sendError = (err) ->
      msg.send "Error: #{err}"

    msg.http("http://www.pivotaltracker.com/services/v3/projects/#{projectId}/iterations/#{type}").headers("X-TrackerToken": token).get() (err, res, body) ->
      sendError(err) if err

      parser.parseString body, (err, json) ->
        sendError(err) if err

        if json.iteration.length?
          for iteration in json.iteration
            sendStories(msg, iteration.stories)
        else
          sendStories(msg, json.iteration.stories)
  
  robot.respond /pivotal\s+username[\s+]?(.+)?/i, (msg) ->
    sender = msg.message.user.name
    users = robot.usersForFuzzyName(sender)
    user = users[0]
    user.pivotalUsername = user.pivotalUsername || ""

    if msg.match[1]?
      user.pivotalUsername = msg.match[1]
      msg.send "#{sender}'s pivotal user name is now #{user.pivotalUsername}"
    else
      msg.send "#{sender}'s pivotal user name is #{user.pivotalUsername}"

  robot.respond /add\s+(bug|feature|chore)\s+(.+)/, (msg) ->
    storyType = msg.match[1]
    story = msg.match[2]
    sender = msg.message.user.name

    users = robot.usersForFuzzyName(sender)
    user = users[0]
    user.pivotalUsername = user.pivotalUsername || ""


    postData = "<story><story_type>#{storyType}</story_type><name>#{story}</name><requested_by>#{sender}</requested_by></story>"

    msg.http("http://www.pivotaltracker.com/services/v3/projects/#{projectId}/stories").headers('X-TrackerToken': token, "Content-type": "application/xml").post(postData) (err, res, body) ->
      sendError(err) if err

  
