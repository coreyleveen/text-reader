module TextReader
  class Reader
    def initialize(img_path)
      @img_path = img_path
      @upload_uri = OCR_BASE_URI + "upload?key=#{ENV['OCR_KEY']}"
    end

    attr_reader :img_path, :upload_uri

    OCR_BASE_URI = "http://api.newocr.com/v1/"
    LANG = "eng"
    PSM = 3
    ROTATE = 0

    def read_image
      retrieve_text(upload_image)
    end

    private

    def upload_image
      upload_request = RestClient::Request.new(
                       :method => :post,
                       :url => upload_uri,
                       :payload => {
                         :multipart => true,
                         :file => File.new(img_path, 'rb')
                       })


      JSON.parse(upload_request.execute)
    end

    def retrieve_text(upload_response)
      if upload_response['status'] == 'success'
        file_id = upload_response['data']['file_id']
        pages = upload_response['data']['pages']

        recognition_uri = OCR_BASE_URI + "ocr?key=#{ENV['OCR_KEY']}&file_id=#{file_id}"\
                          "&page=#{pages}&lang=#{LANG}&psm=#{PSM}&rotate=#{ROTATE}"

        recognition_request = RestClient::Request.new(
                              :method => :get,
                              :url => recognition_uri
                              )


        recognition_response = JSON.parse(recognition_request.execute)

        if recognition_response['status'] == 'success'
          recognition_response['data']['text']
        else
          "Image recognition failed, please try again."
        end

      else
        "Image upload failed, please try again later."
      end
    end
  end
end
