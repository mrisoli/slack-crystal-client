class Slack::RTM::Client
  def initialize(@token)
    @client = HTTP::Client.new "slack.com", ssl: true
  end

  def start
    get_json "/api/rtm.connect", "", RTMConnectResponse
  end

  private def get_json(url, field, klass)
    response = @client.get "#{url}?token=#{@token}"
    handle(response) do
      parse_response response.body, field, klass
    end
  end

  private def parse_response(body, field, klass)
    error = nil

    pull = JSON::PullParser.new(body)
    pull.read_object do |key|
      case key
      when "ok"
        pull.read_bool
      when "error"
        error = pull.read_string
      when field
        return klass.new(pull)
      else
        pull.skip
      end
    end

    raise Error.new(error.not_nil!)
  end

  private def handle(response)
    case response.status_code
    when 200, 201
      yield
    else
      raise Error.new(response)
    end
  end
end
