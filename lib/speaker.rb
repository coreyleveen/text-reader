require 'pry'
module TextReader
  class Speaker
    def initialize(text)
      @text = text
      @authorization = "Bearer #{ENV['VOICE_TOKEN']}"
    end

    attr_accessor :text
    attr_reader :authorization

    VOICE_URI = "https://api.att.com/speech/v3/textToSpeech"

    def speak
      retrieve_sounds
      send_sounds
    end

    private

    def retrieve_sounds
      options = {
        :method => :post,
        'Authorization' => authorization,
        'Content-Type'  => 'text/plain',
        'Accept'        => 'audio/amr-wb'
      }

      RestClient.post(VOICE_URI, keep_alphabetic(text), options) do |response|
        if response.include? "UnAuthorized Request"
          get_new_token
        end
        binding.pry
      end
    end

    def send_sounds
    end

    def keep_alphabetic(str)
      str.gsub(/[^0-9a-z]/i, '').squeeze(' ')
    end

    def get_new_token
      uri = "https://api.att.com/oauth/v4/token"
      data = "client_id=#{ENV['VOICE_KEY']}&client_secret=#{ENV['VOICE_SECRET']}"\
             "&grant_type=client_credentials&scope=TTS"

      options = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/x-www-form-urlencoded',
        :data => data
      }

      RestClient.get(uri, options) do |response|
        binding.pry
      end
    end
  end
end

