require 'sinatra'

set :views, settings.root

enable :sessions


get '/' do
  haml :index
end

post '/upload' do
  File.open('uploads/' << params['cameraInput'][:filename], "w") do |f|
    f.write(params['cameraInput'][:tempfile].read)
  end
  "Uploaded #{params['cameraInput'][:filename]}!"
end
