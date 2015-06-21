require 'sinatra'
require 'rest-client'

enable :sessions

get '/' do
  haml :index
end

post '/upload' do

  filename = params['cameraInput'][:filename]

  file_path = 'uploads/' << filename

  File.open(file_path, 'w') do |f|
    f.write(params['cameraInput'][:tempfile].read)
  end


  OCR_BASE_URI = "http://api.newocr.com/v1/"
  LANG = "eng"
  PSM = 3
  ROTATE = 270

  ocr_upload_uri = OCR_BASE_URI + "upload?key=#{ENV['OCR_KEY']}"

  ocr_upload_request = RestClient::Request.new(
                       :method => :post,
                       :url => ocr_upload_uri,
                       :payload => {
                         :multipart => true,
                         :file => File.new(file_path, 'rb')
                       })

  ocr_upload_response = JSON.parse(ocr_upload_request.execute)


  if ocr_upload_response['status'] == 'success'
    file_id = ocr_upload_response['data']['file_id']
    pages = ocr_upload_response['data']['pages']
    ocr_recognition_uri = OCR_BASE_URI + "ocr?key=#{ENV['OCR_KEY']}&file_id=#{file_id}"\
                                         "&page=#{pages}&lang=#{LANG}&psm=#{PSM}&rotate=#{ROTATE}"

    ocr_recognition_request = RestClient::Request.new(
                              :method => :get,
                              :url => ocr_recognition_uri
                              )

    ocr_recognition_response = JSON.parse(ocr_recognition_request.execute)

    puts ocr_recognition_response['data']['text']

  else
    puts ocr_upload_response["status"]
    puts ocr_upload_response["message"]
  end

  redirect to('/')
end
