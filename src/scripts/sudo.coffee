# Sudo for protected Smith commands.
#
#   sudo [command]
#     Execute the protected command.

class Sudo

  constructor: (robot) ->
    @robot = robot

    #           Gino    Adam    Joanne  Erik   Shell
    @sudoers = [625437, 871643, 889137, 599431, '1']

  respond: (string, execute) =>
    # create a responder for commands that require sudo
    @robot.respond ///#{string}///i, (msg) =>
      msg.send 'This is a protected command, please use sudo.'

    # create a responder for successful sudo commands
    @robot.respond ///sudo\s#{string}///i, (msg) =>
      @authorizeResponse msg, execute

  authorizeResponse: (msg, execute) =>
    userid = msg.message.user.id
    if userid in @sudoers
      msg['message']['done'] = true
      execute msg

module.exports = Sudo

