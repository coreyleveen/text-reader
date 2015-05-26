require 'sinatra'
require 'sinatra/reloader' if development?

also_reload '/public/app.js'
also_reload '/views/index.haml'

enable :sessions


get '/' do
  haml :index
end

post '/upload' do
  if params['cameraInput']
    filename = params['cameraInput'][:filename] << session[:session_id][0...32]

    File.open('uploads/' << filename, "w") do |f|
      f.write(params['cameraInput'][:tempfile].read)
    end

    HTTParty.post("/get_photo",
      :body => { :file => filename }.to_json,
      :headers => { 'Content-Type' => 'application/json' }
    )

    "Uploaded #{filename}!"
  else
    "No file submitted"
  end
end
