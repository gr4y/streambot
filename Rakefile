require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "streambot"
    gem.summary = %Q{retweeting tweets with specified keywords on twitter}
    gem.description = %Q{a simple gem that tracks several keywords via twitter streaming api and re-publish it on twitter}
    gem.email = "swessel@gr4yweb.de"
    gem.homepage = "http://github.com/gr4y/streambot"
    gem.authors = ["Sascha Wessel"]
    gem.require_path = 'lib'
    gem.files = %w(Rakefile) + Dir.glob("{lib}/**/*") + %w(VERSION)
    # the runtime dependencies
    gem.add_runtime_dependency "twistream", "~> 0.2.2"
    gem.add_runtime_dependency "oauth","~> 0.4.0"
    # the development dependencies
    gem.add_development_dependency "bundler", "~> 1.0.0"
    gem.add_development_dependency "rspec", [">= 2.4.0"]
    gem.add_development_dependency "webmock","~> 1.0.0"
    gem.add_development_dependency "rcov","~> 0.9.8"
    gem.add_development_dependency "reek","~> 1.2.8"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "streambot #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'reek/rake/task'
Reek::Rake::Task.new do |t|
  t.fail_on_error = false
  t.verbose = true
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => [:check_dependencies, :spec]
task :default => [:test, :reek, :build]