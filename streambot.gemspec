# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{streambot}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sascha Wessel"]
  s.date = %q{2010-08-27}
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
     "lib/streambot/callbacks.rb",
     "lib/streambot/constants.rb",
     "lib/streambot/filter.rb",
     "lib/streambot/handler.rb",
     "lib/streambot/http.rb",
     "lib/streambot/oauth.rb",
     "lib/streambot/retweet.rb",
     "lib/streambot/tracker.rb"
  ]
  s.homepage = %q{http://github.com/gr4y/streambot}
  s.post_install_message = %q{=== You are upgrading from an earlier version?

Then you maybe need to change your code.
In version 0.4.0 oauth was introduced and I recommend you to read the README

code is available on github[http://github.com/gr4y/streambot] }
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{retweeting tweets with specified keywords on twitter}
  s.test_files = [
    "test/streambot/base_test.rb",
     "test/streambot/test_oauth.rb",
     "test/streambot/test_retweet.rb",
     "test/streambot/test_http.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tweetstream>, [">= 1.0.4"])
      s.add_runtime_dependency(%q<oauth>, [">= 0.4.0"])
      s.add_development_dependency(%q<webmock>, [">= 1.0.0"])
      s.add_development_dependency(%q<rcov>, [">= 0.9.8"])
      s.add_development_dependency(%q<reek>, [">= 1.2.8"])
    else
      s.add_dependency(%q<tweetstream>, [">= 1.0.4"])
      s.add_dependency(%q<oauth>, [">= 0.4.0"])
      s.add_dependency(%q<webmock>, [">= 1.0.0"])
      s.add_dependency(%q<rcov>, [">= 0.9.8"])
      s.add_dependency(%q<reek>, [">= 1.2.8"])
    end
  else
    s.add_dependency(%q<tweetstream>, [">= 1.0.4"])
    s.add_dependency(%q<oauth>, [">= 0.4.0"])
    s.add_dependency(%q<webmock>, [">= 1.0.0"])
    s.add_dependency(%q<rcov>, [">= 0.9.8"])
    s.add_dependency(%q<reek>, [">= 1.2.8"])
  end
end

