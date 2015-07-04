require 'securerandom'
require 'pry'

module TextReader
  BASE_MP3_URI = 'https://api.cloudconvert.com/convert'

  class SpeechInterpreter
    def initialize(sounds)
      @sounds = sounds
      @amr_id = nil
    end

    attr_accessor :amr_id
    attr_reader :sounds, :amr_id

    def interpret
      file_name = create_amr_file
      convert_amr_to_mp3(file_name)
      send_mp3
      delete_amr
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

      mp3_request = RestClient::Request.new(
                    :method => :post,
                    :url => convert_uri,
                    :payload => {
                      :multipart => true,
                      :file => File.new(file_name)
                    })

      res = JSON.parse(mp3_request.execute)
      binding.pry
    end

    def delete_file
    end
  end
end
