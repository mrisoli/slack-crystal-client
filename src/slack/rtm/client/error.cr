class Slack::RTM::Client::Error < Exception
  def initialize(response : HTTP::Response)
    super("Slack::RTM::Error: #{response.status_code}\n#{response.body}")
  end

  def initialize(message)
    super(message)
  end
end
