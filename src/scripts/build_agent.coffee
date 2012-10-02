# Build the System Shepherd Agent installer.
#
# Commands:
#   hubot build windows agent - Build the Windows agent installer and upload it to S3

module.exports = (robot) ->
  robot.respond /build windows agent/, (msg) ->
    spawn = require('child_process').spawn
    fs = require('fs')

    workingCopy = '/mnt/sdf/jruby-agent-windows'
    output = []

    msg.send "I'll get started building the Windows agent installer"

    # Updates the jruby-agent-windows working copy. Either does a clone or a pull
    # depending on whether or not the working copy exists.
    updateRepo = (msg) ->
      msg.send "Cloning the jruby-agent-windows repo"
      fs.exists workingCopy, (exists) ->
        if exists
          msg.send "Executing `git pull`"
          git = spawn('git', ['pull'], { cwd: workingCopy })
          git.stdout.on 'data', (data) -> output.push data
          git.stderr.on 'data', (data) -> output.push data
          git.on 'exit', (code) ->
            if code == 0
              bundleInstall msg
            else
              msg.send "Sorry, but I couldn't update the jruby-agent-windows repo"
              msg.send output.join("\n")
        else
          msg.send "Executing `git clone`"
          git = spawn('git', ['clone', 'git@github.com:absperf/jruby-agent-windows.git', workingCopy])
          git.stdout.on 'data', (data) -> output.push data
          git.stderr.on 'data', (data) -> output.push data
          git.on 'exit', (code) ->
            if code == 0
              bundleInstall msg
            else
              msg.send "Sorry, but I couldn't clone the jruby-agent-windows repo"
              msg.send output.join("\n")

    # Runs `bundle install` for the jruby-agent-windows working copy.
    bundleInstall = (msg) ->
      msg.send "Executing `bundle install`"
      bundle = spawn('bundle', ['install'], { cwd: workingCopy })
      bundle.stdout.on 'data', (data) -> output.push data
      bundle.stderr.on 'data', (data) -> output.push data
      bundle.on 'exit', (code) ->
        if code == 0
          launchVagrant msg
        else
          msg.send "Sorry, but I couldn't run `bundle install` in the jruby-agent-windows repo"
          msg.send output.join("\n")

    # Launches vagrant in the jruby-agent-windows working copy. Either does
    # `vagrant provision` or `vagrant up` depending on whether or not the VM is running.
    launchVagrant = (msg) ->
      msg.send "Executing `vagrant status | grep running`"
      vagrant = spawn('vagrant', ['status'], { cwd: workingCopy })
      grep = spawn('grep', ['running'])

      vagrant.stdout.on 'data', (data) -> grep.stdin.write data

      vagrant.on 'exit', (code) ->
        msg.send("Sorry, but I couldn't figure out if vagrant was running alread") unless code == 0
        grep.stdin.end()

      grep.on 'exit', (code) ->
        if code == 0 then vagrantProvision(msg) else vagrantUp(msg)

    # Runs `vagrant provision` for the jruby-agent-windows working copy.
    vagrantProvision = (msg) ->
      msg.send "Executing `vagrant provision`"
      vagrant = span('vagrant', ['provision'], { cwd: workingCopy })
      vagrant.stdout.on 'data', (data) -> output.push data
      vagrant.stderr.on 'data', (data) -> output.push data
      vagrant.on 'exit', (code) -> vagrantExit code, msg

    # Runs `vagrant up` for the jruby-agent-windows working copy.
    vagrantUp = (msg) ->
      msg.send "Executing `vagrant up`"
      vagrant = span('vagrant', ['up'], { cwd: workingCopy })
      vagrant.stdout.on 'data', (data) -> output.push data
      vagrant.stderr.on 'data', (data) -> output.push data
      vagrant.on 'exit', (code) -> vagrantExit code, msg

    # Handles the completion of vagrant provisioning. If successful, the VM is halted.
    vagrantExit = (code, msg) ->
      if code == 0
        msg.send "The Windows agent installer has been built and uploaded to S3 at https://s3.amazonaws.com/agent-dist/latest/SystemShepherdAgent.exe"
        spawn('vagrant', ['halt'], { cwd: workingCopy })
      else
        msg.send "Sorry, but I couldn't build the Windows agent installer"
        msg.send output.join("\n")

    updateRepo msg
