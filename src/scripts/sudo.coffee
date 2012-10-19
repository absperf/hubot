# Sudo for protected Smith commands
#
#   sudo [my_command]
#     Execute the protected command on successful entry of the generated captcha.

class Sudo

  constructor: (robot) ->
    #           Gino    Adam    Joanne  Erik   Shell
    @sudoers = [625437, 871643, 889137, 599431, '1']
    @robot = robot

    @activeCaptchas = []

    # try to match every recieved chat message to an active sudo captcha
    @robot.hear /(.+)/, (msg) =>
      if @activeCaptchas.length > 0
        msg.message.done = true
        @authorizeResponse msg.message.user.id, msg.match[0]

  generateCaptcha: (msg, callback) =>
    userid = msg.message.user.id
    if userid in @sudoers
      generate = -> Math.random().toString(36).substring(2).match(/\D.+$/)[0]
      captcha = (generate() + generate())[0..7]

      execute = -> callback(msg)
      @activeCaptchas.push { captcha: captcha, execute: execute, userid: userid }
      msg.send 'This captcha will expire in 10 seconds:'
      msg.send captcha

      setTimeout (=> @deactivateCaptcha captcha ), 10000
    else
      msg.send "You don't have permission to execute this command."

  respond: (string, callback) =>
    @robot.respond ///sudo\s#{string}///i, (msg) =>
      @generateCaptcha msg, callback

    @robot.respond ///#{string}///i, (msg) =>
      msg.send 'This is a protected command, please use sudo.'

  deactivateCaptcha: (captcha) =>
    @activeCaptchas = @activeCaptchas.filter (c) -> return c.captcha isnt captcha

  authorizeResponse: (userid, message) =>
    if userid in @sudoers
      for captcha in @activeCaptchas
        if captcha.captcha is message
          @deactivateCaptcha message
          captcha.execute()

module.exports = Sudo

