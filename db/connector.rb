require 'mysql2'

def create_db_client
  client = Mysql2::Client.new(
    :host => '',
    :username => '',
    :password => '',
    :database => ''
  )
  client
end