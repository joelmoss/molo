Molo
====

Rails migrations in non-Rails (and non Ruby) projects.  

Install Ruby, RubyGems and a ruby-database driver (e.g. `gem install mysql`) then:

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
      puts "gem install molo to get db:migrate:* tasks! (Error: #{e})"
    end

Add database configuration to `db/config.yml` in your projects base directory e.g.:

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

    test: &test
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