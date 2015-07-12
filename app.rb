require 'sinatra'
require 'pry'
require 'rest-client'
require_relative 'lib/reader'

get '/' do
  haml :index
end

post '/upload' do
  filename = params['cameraInput'][:filename]

  file_path = 'uploads/' << filename

  File.open(file_path, 'w') do |f|
    f.write(params['cameraInput'][:tempfile].read)
  end

  binding.pry

  RestClient.post '/recognized_text', :text => TextReader::Reader.new(file_path).read_image

  File.delete(file_path)

  redirect to('/')
end
