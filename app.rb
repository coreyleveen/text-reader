require 'sinatra'
require_relative 'lib/reader'

get '/' do
  @text = nil
  haml :index
end

post '/' do
  filename = params['cameraInput'][:filename]

  file_path = 'uploads/' << filename

  File.open(file_path, 'w') do |f|
    f.write(params['cameraInput'][:tempfile].read)
  end

  @text = TextReader::Reader.new(file_path).read_image

  File.delete(file_path)

  haml :index
end
