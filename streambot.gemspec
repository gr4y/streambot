# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{streambot}
  s.version = "1.0.0.rc4"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sascha Wessel"]
  s.date = %q{2011-02-11}
  s.description = %q{a simple gem that tracks several keywords via twitter streaming api and re-publish it on twitter}
  s.email = %q{swessel@gr4yweb.de}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "Rakefile",
    "VERSION",
    "lib/streambot.rb",
    "lib/streambot/array_path.rb",
    "lib/streambot/event.rb",
    "lib/streambot/event_handler.rb",
    "lib/streambot/handler.rb",
    "lib/streambot/oauth.rb",
    "lib/streambot/retweet.rb",
    "lib/streambot/tracker.rb"
  ]
  s.homepage = %q{http://github.com/gr4y/streambot}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  s.summary = %q{retweeting tweets with specified keywords on twitter}
  s.test_files = [
    "spec/retweet_spec.rb",
    "spec/spec_helper.rb",
    "spec/tracker_spec.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<twistream>, ["~> 0.2.5"])
      s.add_runtime_dependency(%q<oauth>, ["~> 0.4.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.4.0"])
      s.add_development_dependency(%q<webmock>, ["~> 1.0.0"])
      s.add_development_dependency(%q<rcov>, ["~> 0.9.8"])
      s.add_development_dependency(%q<reek>, ["~> 1.2.8"])
    else
      s.add_dependency(%q<twistream>, ["~> 0.2.5"])
      s.add_dependency(%q<oauth>, ["~> 0.4.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<rspec>, [">= 2.4.0"])
      s.add_dependency(%q<webmock>, ["~> 1.0.0"])
      s.add_dependency(%q<rcov>, ["~> 0.9.8"])
      s.add_dependency(%q<reek>, ["~> 1.2.8"])
    end
  else
    s.add_dependency(%q<twistream>, ["~> 0.2.5"])
    s.add_dependency(%q<oauth>, ["~> 0.4.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<rspec>, [">= 2.4.0"])
    s.add_dependency(%q<webmock>, ["~> 1.0.0"])
    s.add_dependency(%q<rcov>, ["~> 0.9.8"])
    s.add_dependency(%q<reek>, ["~> 1.2.8"])
  end
end

