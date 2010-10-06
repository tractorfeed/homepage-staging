require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'digest/sha2'

DataMapper.setup(:default, ENV['DATABASE_URL'])

class User
  include DataMapper::Resource

  property :id,         Serial    # An auto-increment integer key
  property :username,   String    :required => true
  property :firstname,  String    :default  => ""
  property :lastname,   String    :default  => ""
  property :link,       String    :default  => ""
  property :about,      Text      :default  => ""
  property :email,      String    :required => true
  property :password,   String    :required => true
  property :confirmed,  Boolean,  :default  => false
  property :role,       String,   :default  => 'member'
  property :created_at, DateTime  # A DateTime, for any date you might like.
  property :last_at,    DateTime
end

configure do
  DataMapper.auto_upgrade!
end

helpers do

  def hashit(pass)
    salt = "some amazingly long and salty bit of stringage"
    Digest::SHA256.digest(pass+salt)
  end
  
  def validate_user()
    new_regex = /\A[a-z]{5}\z/
	if User.first(:username => username).nil?
	  return false
	elsif username.validate(new_regex)
	  return true
	else
	  return false
	end
  end
  
  def validate_email()
  
  end
  
  def validate_pw()
  
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
  if(validate_user() && validate_email() %% validate_pw())
    # create user
    User.create(:username   => , 
                :email      => ,
                :password   => Time.now,
	  	  	    :created_at => Time.now)
    redirect '/thanks'
  else
    redirect '/signup'
  end
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