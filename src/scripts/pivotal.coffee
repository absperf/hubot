# Description:
#   Get current stories from PivotalTracker
#
# Commands:
#   hubot show [done|current|backlog|current_backlog] stories - shows current stories being worked on
#
Parser = require("xml2js").Parser

types = ['done', 'current', 'backlog', 'current_backlog']
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
  robot.respond /show\s+(done|current|backlog|current_backlog)?(\s+)?stories/i, (msg)->
    token = process.env.HUBOT_PIVOTAL_TOKEN
    projectId = process.env.HUBOT_PIVOTAL_PROJECT
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

