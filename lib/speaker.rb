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
      uri = "https://api.att.com/oauth/v4/token"\

      data = {
        :client_id     => ENV['VOICE_KEY'],
        :client_secret => ENV['VOICE_SECRET'],
        :grant_type    => 'client_credentials',
        :scope         => 'TTS'
      }

      RestClient.post(uri, data) do |response|
        res = JSON.parse(response)

        if res['access_token']
          token_data = {
            'VOICE_TOKEN'   => res['access_token'],
            'REFRESH_TOKEN' => res['refresh_token']
          }

          ENV.update(token_data)
        else
          warn res
        end
      end
    end
  end

  class InvalidTokenError < StandardError
  end
end

