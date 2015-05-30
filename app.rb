require 'sinatra'

enable :sessions

get '/' do
  haml :index
end

# post '/to_voice' do
# end
