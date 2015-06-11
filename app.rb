require 'sinatra'
# require 'httmultiparty'
require 'net/http/post/multipart'

enable :sessions

get '/' do
  haml :index
end

post '/upload' do
  filename = params['cameraInput'][:filename]

  File.open('uploads/' << filename, 'w') do |f|
    f.write(params['cameraInput'][:tempfile].read)
  end

  url = URI.parse("http://api.newocr.com/v1/upload?key=#{ENV['OCR_KEY']}")
  res = nil
  File.open("uploads/#{filename}") do |jpg|
    req = Net::HTTP::Post::Multipart.new url.path,
      "file" => UploadIO.new(jpg, "image/jpeg", filename)
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end
  end

  # class SomeClient
  #   include HTTMultiParty
  #   base_uri 'http://api.newocr.com/v1/'
  # end

  # binding.pry

  # response = SomeClient.post("/upload?key=#{ENV['OCR_KEY']}", :query => {
  #   :my_file => File.read('uploads/' << filename)
  # }, :detect_mime_type => true)

  # binding.pry

  redirect to('/')
end
