require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'digest/sha2'

DataMapper.setup(:default, ENV['DATABASE_URL'])
# DataMapper.setup(:default, 'sqlite://local.db')

class User
  include DataMapper::Resource

  property :id,         Serial    # An auto-increment integer key
  property :username,   String,   :required => true, :format => /[a-zA-Z0-9]*/,  :length => 6..20
  property :firstname,  String,   :default  => "",   :format => /[a-zA-Z]*/,     :length => 0..20
  property :lastname,   String,   :default  => "",   :format => /[a-zA-Z]*/,     :length => 0..20
  property :link,       String,   :default  => "",   :format => :url ,           :length => 0..512
  property :about,      Text,     :default  => ""
  property :email,      String,   :required => true, :format => :email_address, :length => 0..256
  property :password,   String,   :required => true, :length => 6..20
  property :confirmed,  Boolean,  :default  => false
  property :role,       String,   :default  => 'member'
  property :created_at, DateTime  # A DateTime, for any date you might like.
  property :last_at,    DateTime
  
  validates_uniqueness_of username, email
end

configure do
  DataMapper.auto_upgrade!
  set :sessions, true
end

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
  user = User.new(:username   => params[:username], 
                  :email      => params[:email],
                  :password   => hashit(params[:password]),
	  	  	      :created_at => Time.now)
  if user.save
    # my_account is valid and has been saved
	redirect '/signup#thanks'
  else
    session[:regErr] = user.errors
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
	session[:regErr]
end

error do
    'wtf'
end 