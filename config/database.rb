
# Connection.new takes host, port
database_name = case Padrino.env
  when :development then 'haircut_development'
  when :production  then 'haircut_production'
  when :test        then 'haircut_test'
end

if uri_string = Hc::Config[:database_uri]
  Mongoid.database = Mongo::Connection.from_uri(uri_string).
                         db(URI.parse(uri_string).path.gsub(/^\//, ''))
else
  host = Hc::Config[:database_host] || "localhost"
  port = Mongo::Connection::DEFAULT_PORT
  Mongoid.database = Mongo::Connection.new(host, port).db(database_name)
end

# You can also configure Mongoid this way
# Mongoid.configure do |config|
#   name = @settings["database"]
#   host = @settings["host"]
#   config.master = Mongo::Connection.new.db(name)
#   config.slaves = [
#     Mongo::Connection.new(host, @settings["slave_one"]["port"], :slave_ok => true).db(name),
#     Mongo::Connection.new(host, @settings["slave_two"]["port"], :slave_ok => true).db(name)
#   ]
# end
#
# More installation and setup notes are on http://mongoid.org/docs/
