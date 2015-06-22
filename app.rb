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
  

    text = TextReader::Reader.new(file_path).read_image

    VOICE_URI = "http://api.ispeech.org/api/rest"

    File.delete(file_path)

  else
    puts ocr_upload_response["status"]
    puts ocr_upload_response["message"]
    File.delete(file_path)
  end

  redirect to('/')
end
