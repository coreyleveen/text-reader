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

  begin
    RestClient.post(ocr_uri, {:myfile => File.new(file_path, 'rb')})
  rescue RestClient::ExceptionWithResponse => err
    err.response
  end

  redirect to('/')
end
