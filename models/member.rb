class Member < Sequel::Model
  
  set_schema do
    primary_key :id
    varchar :username
    varchar :firstname
	varchar :lastname
	varchar :email
    datetime :signupdate
	datetime :accessdate
    varchar :link
	varchar :pass
	boolean :confirmed
	varchar :role
  end
  
  unless table_exists?
    create_table
    create(
      :username => 'admin',
      :firstname=> 'Mr.',
      :lastname=> 'Admin',
      :email=> 'admin@example.com'
	  :signupdate => Time.now,
	  :accessdate => Time.now,
	  :link => 'http://google.com',
	  :confirmed => 1,
	  :pass => hashit("supersecret"),
	  :role => 'superadmin'
    )
  end
  
  sync
  
  def self.ordered(page = 1)
    filter.order(:date.desc).paginate(page.to_i, PAGE_SIZE)
  end
  
  def self.search(q)
    value = "%#{q}%"
    filter(:title.like(value) | :text.like(value)).order(:date.desc)
  end
  
  def self.with_link(value)
    filter(:link => value).order(:date.desc)
  end
  
end