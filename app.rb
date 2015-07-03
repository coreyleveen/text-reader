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

  sounds = TextReader::Speaker.new(text).get_sounds

  TextReader::SpeechInterpreter.new(sounds).interpret

  File.delete(file_path)

  redirect to('/')
end
