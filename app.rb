require 'sinatra'
require 'rest-client'
require_relative 'lib/reader'
require_relative 'lib/speaker'

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
  
  text = TextReader::Reader.new(file_path).read_image

  TextReader::Speaker.new(text).speak

  File.delete(file_path)

  puts ocr_upload_response["status"]
  puts ocr_upload_response["message"]
  File.delete(file_path)

  redirect to('/')
end
