# Build the System Shepherd Agent installer.
#
# Commands:
#   hubot build windows agent - Build the Windows agent installer and upload it to S3
#   hubot build linux agent - Build the Linix agent installer and upload it to S3

module.exports = (robot) ->
  robot.respond /build( the)? (windows|linux) (agent|installer)$/i, (msg) ->

    platform = msg.match[2]
    spawn = require('child_process').spawn
    fs = require('fs')

    workingCopy = "/home/ubuntu/jruby-agent-#{platform}"
    output = []

    msg.send "I'll get started building the #{platform} agent installer."

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
            buildWindows msg
          else
            buildLinux(msg, 'i586')
        else
          msg.send output.join("\n")
          msg.send "Sorry, but I couldn't run `bundle install` in the jruby-agent-#{platform} repo:"

    buildLinux = (msg, arch) ->
      rake = spawn('bundle', ['exec', 'rake', "build_and_upload:#{arch}"], { cwd: workingCopy })
      rake.stdout.on 'data', (data) -> output.push(data)
      rake.stderr.on 'data', (data) -> output.push(data)
      rake.on 'exit', (code) ->
        if code == 0
          msg.send "The #{platform} #{arch} agent installer has been built and uploaded to s3 at https://s3.amazonaws.com/agent-dist/latest/agent-linux-#{arch}.sh"
        else
          msg.send output.join("\n")
          msg.send "Sorry, but I couldn't build the #{platform} agent installer."

        buildLinux(msg, 'x86_64') unless arch == 'x86_64'

    # Runs chef solo to build and upload the installer.
    buildWindows = (msg) ->
      chef = spawn('sudo', ['chef-solo', '-c', "#{workingCopy}/chef/solo.rb", '-j', "#{workingCopy}/chef/solo.json"], { cwd :workingCopy })
      chef.stdout.on 'data', (data) -> output.push(data)
      chef.stderr.on 'data', (data) -> output.push(data)
      chef.on 'exit', (code) ->
        if code == 0
          msg.send "The #{platform} agent installer has been built and uploaded to S3 at https://s3.amazonaws.com/agent-dist/latest/SystemShepherdAgent.exe."
        else
          msg.send output.join("\n")
          msg.send "Sorry, but I couldn't build the #{platform} agent installer."

    updateRepo msg
