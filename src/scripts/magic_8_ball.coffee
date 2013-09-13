# Description:
#   A Magic 8 Ball
#
# Commands:
#   smith [is|does|can|will] [a question]?

module.exports = (robot) ->

  robot.respond /(is|does|can|will) (.+)\?/i, (msg) ->

    # https://en.wikipedia.org/wiki/Magic_8-Ball
    magic_8_ball = ['It is certain.',
                    'It is decidedly so.',
                    'Without a doubt.',
                    'Yes definitely.',
                    'You may rely on it.',
                    'As I see it yes.',
                    'Most likely.',
                    'Outlook good.',
                    'Yes.',
                    'Signs point to yes.',
                    'Reply hazy try again.',
                    'Ask again later.',
                    'Better not tell you now.',
                    'Cannot predict now.',
                    'Concentrate and ask again.',
                    "Don't count on it.",
                    'My reply is no.',
                    'My sources say no.',
                    'Outlook not so good.',
                    'Very doubtful.']

    msg.send magic_8_ball[Math.floor(Math.random() * magic_8_ball.length)]

