require 'tesseract'

module TextReader
  class Reader
    def initialize(img_path)
      @img_path = img_path
    end

    attr_reader :img_path

    def read_image
      engine = Tesseract::Engine.new do |e|
        e.language  = :eng
        e.blacklist = '|'
      end

      engine.text_for(img_path).strip
    end
  end
end
