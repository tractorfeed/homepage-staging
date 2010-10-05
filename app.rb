require 'rubygems'
require 'sinatra'

# display the index page
get '/' do
 erb :index
end

get '/members' do
 erb :members
end

get '/members/:name' do
 @name = params[:name]
 erb :member
end

get '/events' do
 erb :events
end

get '/sponsor' do
 erb :sponsor
end

get '/contact' do
 erb :contact
end

get '/signup' do
 erb :signup
end

# for monitoring unicorn status
get '/monitor2.html' do
 erb :monitor2
end

# trap those nasty errors
not_found do
    'This is nowhere to be found'
end

error 403 do
    'Access forbidden'
end

error 405..510 do
    'Boom'
end 