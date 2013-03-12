# Build the System Shepherd Agent installer.
#
# Commands:
#   hubot build [windows|linux] [branch] agent - Build the agent installer and upload it to S3

spawn = require('child_process').spawn
fs = require('fs')

rooms = {
  dev: process.env.DEV
  # ops: process.env.OPS
}

module.exports = (robot) ->
  robot.respond /(what are|where are|give me|print|show) the agent (link|installer)(s)?( are)?/i, (msg) ->

    links = [
      "Windows Edge: https://s3.amazonaws.com/agent-dist/latest/SystemShepherdAgent-i586-dev.exe ",
      "Windows Master: https://s3.amazonaws.com/agent-dist/latest/SystemShepherdAgent-x86_64.exe ",
      "Windows Edge i586: https://s3.amazonaws.com/agent-dist/latest/SystemShepherdAgent-i586-dev.exe ",
      "Windows Master x86_64: https://s3.amazonaws.com/agent-dist/latest/SystemShepherdAgent-x86_64.exe ",
      "Linux Edge i586: https://s3.amazonaws.com/agent-dist/latest/agent-linux-i586-dev.sh ",
      "Linux Edge x86_64: https://s3.amazonaws.com/agent-dist/latest/agent-linux-x86_64-dev.sh ",
      "Linux Master i586: https://s3.amazonaws.com/agent-dist/latest/agent-linux-i586.sh ",
      "Linux Master x86_64: https://s3.amazonaws.com/agent-dist/latest/agent-linux-x86_64.sh "
    ]

    for link in links
      msg.send link

  robot.respond /(make|build)( .+)? (some|both)( .+)? (agents|installers|magic)( again)?(!)?/i, (msg) ->

    for platform in ['linux', 'windows']
      msg.message.text = "smith build the #{platform} edge agent"
      robot.receive msg.message

    msg['message']['done'] = true

  robot.respond /build( the)? (windows|linux) (master|edge) (agent|installer)$/i, (msg) ->
    platform = msg.match[2]
    branch = msg.match[3]

    tag = if branch == 'edge' then '-dev' else ''

    workingCopy = "/home/ubuntu/jruby-agent-#{platform}"
    output = []

    msg.send "I'll get started building the #{branch} #{platform} agent installer."

    # Updates the jruby-agent working copy. Either does a clone or a pull
    # depending on whether or not the working copy exists.
    updateRepo = (msg) ->
      fs.exists workingCopy, (exists) ->
        if exists
          git = spawn('git', ['pull'], { cwd: workingCopy })
          git.stdout.on 'data', (data) -> output.push(data)
          git.stderr.on 'data', (data) -> output.push(data)
          git.on 'exit', (code) ->
            if code == 0
              updateSubmodules msg
            else
              msg.send output.join("\n")
              msg.send "Sorry, but I couldn't update the jruby-agent-#{platform} repo:"
        else
          git = spawn('git', ['clone', "git@github.com:absperf/jruby-agent-#{platform}.git", workingCopy])
          git.stdout.on 'data', (data) -> output.push(data)
          git.stderr.on 'data', (data) -> output.push(data)
          git.on 'exit', (code) ->
            if code == 0
              updateSubmodules msg
            else
              msg.send output.join("\n")
              msg.send "Sorry, but I couldn't clone the jruby-agent-#{platform} repo:"

    # Runs `git submodule update --init` for the jruby-agent working copy.
    updateSubmodules = (msg) ->
      git = spawn('git', ['submodule', 'update', '--init'], { cwd: workingCopy })
      git.stdout.on 'data', (data) -> output.push(data)
      git.stderr.on 'data', (data) -> output.push(data)
      git.on 'exit', (code) ->
        if code == 0
          bundleInstall msg
        else
          msg.send output.join("\n")
          msg.send "Sorry, but I couldn't update the git submodules for the jruby-agent-#{platform} repo:"

    # Runs `bundle install` for the jruby-agent working copy.
    bundleInstall = (msg) ->
      bundle = spawn('bundle', ['install'], { cwd: workingCopy })
      bundle.stdout.on 'data', (data) -> output.push(data)
      bundle.stderr.on 'data', (data) -> output.push(data)
      bundle.on 'exit', (code) ->
        if code == 0
          if platform == 'windows'
            buildWindows(msg, 'i586')
          else
            buildLinux(msg, 'i586')
        else
          msg.send output.join("\n")
          msg.send "Sorry, but I couldn't run `bundle install` in the jruby-agent-#{platform} repo:"

    buildLinux = (msg, arch) ->
      rake = spawn('rake', ["build:#{branch}:#{arch}:upload"], { cwd: workingCopy })
      rake.stdout.on 'data', (data) -> output.push(data)
      rake.stderr.on 'data', (data) -> output.push(data)
      rake.on 'exit', (code) ->
        if code == 0
          for room_name, room_id of rooms
            robot.messageRoom room_id, "The #{platform} #{arch}(#{branch}) agent installer has been built and uploaded to s3 at https://s3.amazonaws.com/agent-dist/latest/agent-linux-#{arch}#{tag}.sh"
        else
          msg.send output.join("\n")
          msg.send "Sorry, but I couldn't build the #{platform} #{arch}(#{branch}) agent installer."

        buildLinux(msg, 'x86_64') unless arch == 'x86_64'

    # Runs chef solo to build and upload the installer.
    buildWindows = (msg, arch) ->
      chef = spawn('sudo', ['bundle', 'exec', 'chef-solo', '-c', "#{workingCopy}/chef/solo.rb", '-j', "#{workingCopy}/chef/#{branch}-#{arch}-solo.json"], { cwd :workingCopy })
      chef.stdout.on 'data', (data) -> output.push(data)
      chef.stderr.on 'data', (data) -> output.push(data)
      chef.on 'exit', (code) ->
        if code == 0
          for room_name, room_id of rooms
            robot.messageRoom room_id, "The #{platform} #{arch}(#{branch}) agent installer has been built and uploaded to S3 at https://s3.amazonaws.com/agent-dist/latest/SystemShepherdAgent-#{arch}#{tag}.exe."
        else
          msg.send output.join("\n")
          msg.send "Sorry, but I couldn't build the #{platform} #{arch}(#{branch}) agent installer."

        buildWindows(msg, 'x86_64') unless arch == 'x86_64'

    updateRepo msg
