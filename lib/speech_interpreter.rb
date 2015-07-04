require 'securerandom'

module TextReader
  class SpeechInterpreter
    def initialize(sounds)
      @sounds = sounds
    end

    attr_reader :sounds

    def interpret
      create_amr_file
      convert_amr_to_mp3
      send_mp3
      delete_amr
      delete_mp3
    end

    def create_amr_file
      ## Create amr file with unique filename

      id = SecureRandom.hex

      file_name = "amr/#{id}.amr"

      File.open(file_name, 'w') do |f|
        f.write(sounds)
      end
    end

    def delete_file
    end
  end
end
