# Lookup for IP address information
#
# Commands:
#   hubot whois [ip_address]

module.exports = (robot) ->
  robot.respond /whois (.+)/i, (msg) ->
    ip = msg.match[1]

    msg.http("http://ip-api.com/json/#{ip}")
      .header('accept', 'application/json')
      .get() (err, res, body) ->
        response = JSON.parse(body)

        if response['status'] == 'success'
          message = [
            "IP: #{ip}",
            "Reverse Lookup: #{response.reverse}",
            "Organization: #{response.org}",
            "ISP: #{response.isp}",
            "Location: #{response.city}, #{response.region}"
          ]
          map = "https://maps.google.com/maps?daddr=#{response.lat},#{response.lon}"

          msg.send message.join("\n")
          setTimeout (-> msg.send map), 2000
        else
          msg.send "I couldn't find #{response.query}: #{response.message}"

