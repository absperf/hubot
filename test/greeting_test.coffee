Tests  = require './tests'
assert = require 'assert'
helper = Tests.helper()

require('../src/hubot/scripts/greeting') helper

# start up a danger room for google images
danger = Tests.danger helper, (req, res, url) ->
  res.writeHead 200
  res.end JSON.stringify(
    {responseData: {results: [
      {unescapedUrl: "(#{url.query.q})"}
    ]}}
  )

# callbacks for when hubot sends messages
tests = [
  (msg) -> assert.equal "Hello!", msg
]

# run the async tests
danger.start tests, ->
  helper.receive 'Joanne C. has entered the room.'
