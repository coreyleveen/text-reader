module TextReader
  VOICE_URI = "http://api.ispeech.org/api/rest"
  class Speaker
    def initialize(text)
      @text = text
      @voice_key = ENV['VOICE_KEY']
      @voice_secret = ENV['VOICE_SECRET']
    end

    attr_reader :text

    def speak
      retrieve_sounds
      send_sounds
    end

    private

    def retrieve_sounds
      sound_request = RestClient::Request.new(
                      :method 
    end
     
  end
end

