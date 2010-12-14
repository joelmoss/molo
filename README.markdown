Molo (We're riding solo!)
====

Molo provides Rails database migrations for non-Rails and non-Ruby projects. By dropping a Rakefile into your projects root, Molo will provide you with a list of Rake tasks for managing your database schema and data.

The following tasks are provided:

    rake db:data:dump       # Dump contents of database to db/data.extension (defaults to yaml)
    rake db:data:dump_dir   # Dump contents of database to db/data/tablename.extension (defaults to yaml)
    rake db:data:load       # Load contents of db/data.extension (defaults to yaml) into database
    rake db:data:load_dir   # Load contents of db/data/* into database
    rake db:dump            # Dump schema and data to db/schema.rb and db/data.yml
    rake db:load            # Load schema and data from db/schema.rb and db/data.yml
    rake db:migrate         # Migrate the database using the scripts in the migrations directory.
    rake db:migrate:down    # Runs the "down" for a given migration VERSION.
    rake db:migrate:redo    # Rollbacks the database one migration and re migrate up (options: STEP=x, VERSION=x).
    rake db:migrate:status  # Display status of migrations
    rake db:migrate:up      # Runs the "up" for a given migration VERSION.
    rake db:new_migration   # Create a new migration
    rake db:rollback        # Rolls the schema back to the previous version (specify steps w/ STEP=n).
    rake db:schema:dump     # Create schema.rb file that can be portably used against any DB supported by AR
    rake db:schema:load     # Load a ar_schema.rb file into the database
    rake db:test:load       # Recreate the test database from the current schema.rb
    rake db:test:prepare    # Check for pending migrations and load the test schema
    rake db:test:purge      # Empty the test database
    rake db:version         # Retrieves the current schema version number

### Installation

Install Ruby, RubyGems and a ruby-database driver (e.g. `gem install mysql2`) then:

    sudo gem install molo

Add to `Rakefile` in your projects base directory:

    begin
      require 'tasks/molo'
      MigratorTasks.new do |t|
        # t.migrations = "db/migrations"
        # t.config = "db/config.yml"
        # t.schema = "db/schema.rb"
        # t.env = "DB"
        # t.default_env = "development"
        # t.verbose = true
        # t.log_level = Logger::ERROR
      end
    rescue LoadError => e
      puts "Run 'gem install molo' to get db:migrate:* tasks! (Error: #{e})"
    end

Create a `db` directory at your project root and add database configuration to `db/config.yml`. Here's an example DB config.

    development:
      adapter: sqlite3
      database: db/development.sqlite3
      pool: 5
      timeout: 5000

    production:
      adapter: mysql
      encoding: utf8
      reconnect: false
      database: somedatabase_dev
      pool: 5
      username: root
      password:
      socket: /var/run/mysqld/mysqld.sock

    test:
      adapter: sqlite3
      database: db/test.sqlite3
      pool: 5
      timeout: 5000

### To create a new database migration:

    rake db:new_migration name=FooBarMigration
    edit db/migrations/20081220234130_foo_bar_migration.rb

... and fill in the up and down migrations [Cheatsheet](http://dizzy.co.uk/ruby_on_rails/cheatsheets/rails-migrations).

If you're lazy and want to just execute raw SQL:

    def self.up
      execute "insert into foo values (123,'something');"
    end

    def self.down
      execute "delete from foo where field='something';"
    end

### To apply your newest migration:

    rake db:migrate

### To migrate to a specific version (for example to rollback)

    rake db:migrate VERSION=20081220234130

### To migrate a specific database (for example your "testing" database)

    rake db:migrate DB=test

### To execute a specific up/down of one single migration

    rake db:migrate:up VERSION=20081220234130

Contributors
============
This work is based on [Lincoln Stoll's blog post](http://lstoll.net/2008/04/stand-alone-activerecord-migrations/) and [David Welton's post](http://journal.dedasys.com/2007/01/28/using-migrations-outside-of-rails).

 - [Joel Moss](http://developwithstyle.com/)
 - [Todd Huss](http://gabrito.com/)
 - [Michael Grosser](http://pragmatig.wordpress.com)
 - [Eric Lindvall](http://bitmonkey.net)
 - [Steve Hodgkiss](http://stevehodgkiss.com/)