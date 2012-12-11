#'\u0131\u0323'

# Description:
#   Flip something.
#
# Commands:
#   hubot flip [a|the|an] [table|something]

module.exports = (robot) ->
  robot.respond /flip (a |the |an )?(.+)/i, (msg) ->
    message = msg.match[2]
    if message.match(/table/)
      message = '┬──┬'
      flipped_message = '┻━━┻'
    else
      flipped_message = flip_message(message)

    msg.send("(╯°□°）╯︵ #{flipped_message}")
    setTimeout (-> msg.send "#{message} ノ(º_ºノ)"), 10000

  flip_message = (message) ->
    message = message.toLowerCase()
    result = ""
    i = message.length - 1
    while i >= 0
      result += flip_character(message.charAt(i))
      --i
    result

  flip_character = (character) ->
    switch character
      when 'a' then "ɐ"
      when 'b' then "q"
      when 'c' then "ɔ"
      when 'd' then "p"
      when 'e' then "ǝ"
      when 'f' then "ɟ"
      when 'g' then "b"
      when 'h' then "ɥ"
      when 'i' then "ı"
      when 'j' then "ɾ"
      when 'k' then "ʞ"
      when 'l' then "ן"
      when 'm' then "ɯ"
      when 'n' then "u"
      when 'o' then "o"
      when 'p' then "d"
      when 'q' then "b"
      when 'r' then "ɹ"
      when 's' then "s"
      when 't' then "ʇ"
      when 'u' then "n"
      when 'v' then "ʌ"
      when 'w' then "ʍ"
      when 'x' then "x"
      when 'y' then "ʎ"
      when 'z' then "z"
      when '[' then "]"
      when ']' then "["
      when '(' then ")"
      when ')' then "("
      when '{' then "}"
      when '}' then "{"
      when '?' then "¿"
      when "¿" then "?"
      when '!' then "¡"
      when "'" then ","
      when ',' then "'"
      when '.' then "˙"
      when '_' then "‾"
      when ';' then "؛"
      when '9' then "6"
      when '6' then '9'
      else character

