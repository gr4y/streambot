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
    gem.post_install_message = File.exist?('USAGE.rdoc') ? File.read('USAGE.rdoc') : ""
    gem.require_path = 'lib'
    gem.files = %w(Rakefile) + Dir.glob("{lib}/**/*")
    
    # Dependency for dealing with twitter streaming API
    gem.add_dependency "tweetstream",">= 1.0.4"
    gem.add_development_dependency "webmock",">= 1.0.0"
    gem.add_development_dependency "rcov",">= 0.9.8"
    gem.add_development_dependency "reek",">= 1.2.8"
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :build_gem => [:test,:rdoc,:build]
task :default => [:check_dependencies,:rcov,:reek,:build_gem]

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
