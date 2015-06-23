module TextReader
  class Speaker
    def initialize(text)
      @text = text
      @voice_key    = ENV['VOICE_KEY']
      @voice_secret = ENV['VOICE_SECRET']
    end

    attr_reader :text

    VOICE_URI     = "http://api.ispeech.org/api/rest"
    ACTION        = "convert"
    VOICE         = "usenglishfemale"
    FORMAT        = "mp3"
    FREQUENCY     = 44100
    BITRATE       = 128
    SPEED         = 1
    START_PADDING = 1
    END_PADDING   = 1
    PITCH         = 110
    FILENAME      = "voice_file"

    def speak
      retrieve_sounds
      send_sounds
    end

    private

    def retrieve_sounds
      uri = VOICE_URI + "?apikey=#{voice_key}&action=#{ACTION}"\
                        "&text=#{text}&voice=#{VOICE}"\
                        "&format=#{FORMAT}&frequency=#{FREQUENCY}"\
                        "&bitrate=#{BITRATE}&speed=#{SPEED}"\
                        "&startpadding=#{START_PADDING}"\
                        "&endpadding=#{END_PADDING}"\
                        "&pitch=#{PITCH}&filename=#{FILENAME}"

      sound_request = RestClient::Request.new(
                      :method 
    end
     
  end
end

