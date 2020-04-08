require "json"

class Slack::RTM::Client::RTMConnectResponse
  JSON.mapping(
    ok: Bool,
    self: SlackUser,
    team: SlackTeam,
    url: String
  )

  class SlackUser
    JSON.mapping(
      id: String,
      name: String
    )
  end

  class SlackTeam
    JSON.mapping(
      domain: String,
      id: String,
      name: String
    )
  end
end

