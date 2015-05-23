require 'sinatra'

enable :sessions


get '/' do
  haml :index
end

post '/upload' do
  id = session[:session_id][0...32]

  File.open('uploads/' << params['cameraInput'][:filename] << id, "w") do |f|
    f.write(params['cameraInput'][:tempfile].read)
  end

  "Uploaded #{params['cameraInput'][:filename]}!"
end
