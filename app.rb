require 'sinatra'

require 'sinatra/reloader' if development?
also_reload '/public/app.js'
also_reload '/views/index.haml'

enable :sessions


get '/' do
  haml :index
end

post '/to_voice' do

end
