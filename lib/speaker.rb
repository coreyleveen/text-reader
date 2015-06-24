module TextReader
  class Speaker
    def initialize(text)
      @text = URI.escape(text)
      @authorization = "Bearer #{ENV['VOICE_TOKEN']}"
    end

    attr_reader :text, :authorization

    VOICE_URI     = "https://api.att.com/speech/v3/textToSpeech"

    def speak
      retrieve_sounds
      send_sounds
    end

    private

    def retrieve_sounds
      uri = VOICE_URI + "?authorization=#{authorization}" 

      sound_request = RestClient::Request.new(
                      :method => :post,
                      :url => uri,
                      :headers => {
                        'Authorization' => authorization,
                        'Content-Type'  => 'text/plain'
                      },
                      :body => text
                      )

      sound_response = JSON.parse(sound_request.execute)
    end
     
  end
end

