module TextReader
  class Speaker
    def initialize(text)
      @text = text
    end

    attr_accessor :text

    VOICE_URI = "https://api.att.com/speech/v3/textToSpeech"

    def speak
      retrieve_sounds
      send_sounds
    end

    private

    def retrieve_sounds
      options = {
        :method => :post,
        'Authorization' => "Bearer #{ENV['VOICE_TOKEN']}",
        'Content-Type'  => 'text/plain',
        'Accept'        => 'audio/amr-wb'
      }

      retries = 1 

      begin
        RestClient.post(VOICE_URI, keep_alphabetic(text), options) do |response|
          if response.include? "UnAuthorized Request"
            raise InvalidTokenError, "Invalid token!"
          end
        end
      rescue InvalidTokenError => e
        warn e.message
        refresh_token
        if retries > 0
          retries -= 1
          retry
        end
      end
    end

    def send_sounds
    end

    def keep_alphabetic(str)
      str.gsub(/[^0-9a-z]/i, '').squeeze(' ')
    end

    def refresh_token
      uri = "https://api.att.com/oauth/v4/token"

      data = "client_id=#{ENV['VOICE_KEY']}&client_secret=#{ENV['VOICE_SECRET']}"\
             "&grant_type=refresh_token&refresh_token=#{ENV['VOICE_REFRESH']}"

      options = {
        :accept       => 'application/json',
        :content_type => 'application/x-www-form-urlencoded'
      }

      RestClient.post(uri, data, options) do |response|
        res = JSON.parse(response)
        ENV['VOICE_TOKEN'] = res['access_token']
      end
    end
  end

  class InvalidTokenError < StandardError
  end
end

