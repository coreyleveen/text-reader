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

  ocr_uri = "http://api.newocr.com/v1/upload?key=#{ENV['OCR_KEY']}"

  request = RestClient::Request.new(
            :method => :post,
            :url => ocr_uri,
            :payload => {
              :multipart => true,
              :file => File.new(file_path, 'rb')
            })

  response = request.execute

  redirect to('/')
end
