task :default => :spec
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new {|t| t.spec_opts = ['--color']}

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'molo'
    gem.summary = "A thin wrapper to use Rails Migrations in non Rails projects"
    gem.email = "joel@developwithstyle.com"
    gem.homepage = "http://codaset.com/joelmoss/molo"
    gem.authors = ["Joel Moss","Todd Huss", "Michael Grosser"]
    gem.files += ["lib/tasks/*"]
    gem.add_dependency "activerecord", "~> 3.0.3"
    gem.add_dependency "rake", "~> 0.8"
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install jeweler"
end
