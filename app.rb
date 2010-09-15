require 'rubygems'
require 'sinatra'
require 'haml'

# display the index page
get '/' do
 haml :index
end

# handle form submissions
post '/' do
 sofa = Lead.new(:name => params[:bar]).save!
 haml :rcvd
end