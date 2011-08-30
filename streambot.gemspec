$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = %q{streambot}
  s.version = File.read('VERSION');
  s.platform = Gem::Platform::RUBY
  s.authors = ["Sascha Wessel"]
  s.email = %q{swessel@gr4yweb.de}
  s.homepage = %q{http://github.com/gr4y/streambot}
  s.summary = %q{retweeting tweets with specified keywords on twitter}
  s.description = %q{a simple gem that tracks several keywords via twitter streaming api and re-publish it on twitter}

  s.rubyforge_project = "streambot"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "twistream", "~> 0.3.0"
  s.add_dependency "oauth", "~> 0.4.5"

  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
  s.add_development_dependency "yard", "~> 0.7.2"
  s.add_development_dependency "rspec", ">= 2.4.0"
  s.add_development_dependency "webmock", "~> 1.0.0"

end

