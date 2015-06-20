require 'sinatra'
require 'rest-client'
require 'pry'

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


  ocr_upload_uri = "http://api.newocr.com/v1/upload?key=#{ENV['OCR_KEY']}"

  ocr_upload_request = RestClient::Request.new(
                       :method => :post,
                       :url => ocr_upload_uri,
                       :payload => {
                         :multipart => true,
                         :file => File.new(file_path, 'rb')
                       })

  ocr_upload_response = JSON.parse(ocr_upload_request.execute)


  if ocr_upload_response["status"] == "success"
    file_id = ocr_upload_response["file_id"]
    pages = ocr_upload_response["pages"]
    ocr_recognition_uri = "http://api.newocr.com/v1/ocr?key=#{ENV['OCR_KEY'}&file_id=#{file_id}&page=#{pages}"

    ocr_recognition_request = RestClient::Request.new(
                              :method => :get,
                              :url => ocr_recognition_uri
                              )

    ocr_recognition_response = JSON.parse(ocr_recognition_request.execute)
    binding.pry

  else 
    puts ocr_upload_response["status"]
    puts ocr_upload_response["message"]
  end

  binding.pry

#  ocr_recognition_request = RestClient::Request.new(
#                            :method => :get,
#:url => 
          



  redirect to('/')
end
