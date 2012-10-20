# Sudo for protected Smith commands.
#
#   sudo [command]
#     Execute the protected command.


defaultSudoers = [
  process.env.GINO_ID,
  process.env.ADAM_ID,
  process.env.JOANNE_ID,
  process.env.ERIK_ID,
  '1'] # Shell is the string '1' :\

class Sudo

  constructor: (robot, sudoers = defaultSudoers) ->
    @robot = robot
    @sudoers = sudoers

  respond: (regex, execute) =>
    # create a responder to deny access to commands without sudo
    @robot.respond RegExp("#{regex.source}"), (msg) =>
      @failedCommand msg, execute

    # create a responder for successful sudo commands
    @robot.respond RegExp("sudo #{regex.source}"), (msg) =>
      @authorizeResponse msg, execute

  failedCommand: (msg, execute) =>
    msg['message']['done'] = true
    msg.send 'This is a protected command, please use sudo.'

  authorizeResponse: (msg, execute) =>
    if "#{msg.message.user.id}" in @sudoers
      msg['message']['done'] = true
      execute msg
    else
      msg.send "You do not have permission to execute that command."

module.exports = Sudo

