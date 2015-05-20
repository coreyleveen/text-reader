require 'sinatra'
set :views, settings.root

enable :sessions

get '/' do
  haml :index
end
