require 'sinatra'
require 'httmultiparty'

enable :sessions

get '/' do
  haml :index
end

post '/upload' do
  filename = params['cameraInput'][:filename]

  File.open('uploads/' << filename, 'w') do |f|
    f.write(params['cameraInput'][:tempfile].read)
  end

  class SomeClient
    include HTTMultiParty
    base_uri 'http://api.newocr.com/v1/'
  end

  response = SomeClient.post("/upload?key=#{ENV['OCR_KEY']}", :query => {
    :my_file => File.read('uploads/' << filename)
  }, :detect_mime_type => true)

  redirect to('/')
end
