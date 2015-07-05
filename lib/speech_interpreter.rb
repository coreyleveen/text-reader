require 'securerandom'
module TextReader

  class SpeechInterpreter
    def initialize(sounds)
      @sounds = sounds
      @amr_id = nil
    end

    attr_accessor :amr_id
    attr_reader :sounds, :amr_id

    BASE_MP3_URI = 'https://api.cloudconvert.com/convert'

    def interpret
      amr_file_name = create_amr_file
      convert_amr_to_mp3(amr_file_name)
      send_mp3
      delete_amr(amr_file_name)
      delete_mp3
    end

    private

    def create_amr_file
      ## Create amr file with unique filename

      amr_id = SecureRandom.hex

      file_name = "amr/#{amr_id}.amr"

      File.open(file_name, 'w') do |f|
        f.write(sounds)
      end

      return file_name
    end

    def convert_amr_to_mp3(file_name)
      api_key = ENV['CONVERT_KEY']

      convert_uri = "#{BASE_MP3_URI}?apikey=#{api_key}&input=upload"\
                    "&download=inline&inputformat=amr&outputformat=mp3"

      RestClient.post convert_uri, :myfile => File.new(file_name, 'rb') do |res|
        # Handle mp3 response
      end
    end

    def delete_amr(file)
      File.delete(file)
    end
  end
end
