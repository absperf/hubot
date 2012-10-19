# Sudo for protected Smith commands.
#
#   sudo [command]
#     Execute the protected command.

class Sudo

  constructor: (robot) ->
    @robot = robot
    #           Gino    Adam    Joanne  Erik   Shell
    @sudoers = [625437, 871643, 889137, 599431, '1']

  respond: (regex, execute) =>
    # create a responder to deny access to commands without sudo
    @robot.respond regex, (msg) => @failedCommand msg, execute

    # create a responder for successful sudo commands
    @robot.respond RegExp("sudo #{regex.source}"), (msg) =>
      @authorizeResponse msg, execute

  failedCommand: (msg, execute) =>
    msg['message']['done'] = true
    msg.send 'This is a protected command, please use sudo.'

  authorizeResponse: (msg, execute) =>
    if msg.message.user.id in @sudoers
      msg['message']['done'] = true
      execute msg

module.exports = Sudo

