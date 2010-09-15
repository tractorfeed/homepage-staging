require 'relaxdb'
class User < RelaxDB::Document
 RelaxDB.configure :host => "localhost", :port => 5984
 RelaxDB.use_db "relaxdb_scratch"
 property :email
end