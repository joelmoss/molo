print "Using native MySQL\n"

adapter_name = 'mysql'
config = YAML.load_file(File.join(File.dirname(__FILE__), '/../../connection.yml'))[adapter_name]

#require 'logger'
#ActiveRecord::Base.logger = Logger.new("debug.log")

ActiveRecord::Base.silence do
  ActiveRecord::Base.configurations = {
    config['database'] => {
    :adapter  => adapter_name,
    :username => config['username'],
    :password => config['password'],
    :host     => config['host'],
    :database => config['database'],
    :encoding => config['encoding'],
    :schema_file => config['schema_file'],
  }
  }

  ActiveRecord::Base.establish_connection config['database']
  ActiveRecord::Migration.verbose = false

  puts "Resetting database"
  conn = ActiveRecord::Base.connection
  conn.recreate_database(conn.current_database)
  conn.reconnect!
  lines = open(File.join(File.dirname(__FILE__), ActiveRecord::Base.configurations[config['database']][:schema_file])).readlines
  lines.join.split(';').each { |line| conn.execute(line) }
  conn.reconnect!
end
