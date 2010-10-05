require 'rubygems'
require 'sinatra'
require 'digest/sha2'

helpers do

  def hashit(pass)
    salt = "some amazingly long and salty bit of stringage"
    Digest::SHA256.digest(pass+salt)
  end

end



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

post '/signup' do
  # create user
  
end

# used for monitoring unicorn status
# ( monitor1 is for nginx...)
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

error 500 do
    'Boom'
end

error do
    'wtf'
end 