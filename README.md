Installation
============

the streambot gem is available on [rubygems.org][1]
to get streambot installed, you simply need to run

stable release
--------------
	gem install streambot

development release
-------------------

	gem install streambot --pre

Documentation
=============

The full rdoc is available on [rdoc.info][2]

Usage
=====

	require 'streambot'
	
	@params = { 'auth' => { 'username' => 'your username', 'password' => 'your password' },
		'oauth' => { 'key' => 'your consumer key', 'secret' => 'your consumer secret' },
 		'keywords' => ['nowplaying'] }
		
		
	bot = StreamBot::Tracker.new(@params)
	bot.start

Configuration
=============

Twitter has finally removed the http basic authentication for the REST API.
The Streaming API, which the tracker is using, still works with http basic authentication only.
So we still need both, the oauth credentials for retweeting and the http basic authentication credentials for tracking. 

You need to register an application of the type desktop application on [dev.twitter.com][3] first!

oauth
-----

- key: The consumer key Twitter provides you
- secret: The consumer secret Twitter provides you

auth
----

- username: Your login username
- password: Your login password

keywords 
--------
the list of keywords as an array

filters_config [[available filters](#Filters)]
--------------------------------------------
the path to the filters.yml file 

I wrote this stuff into my config.yml and load the params with 

	require 'yaml'
	@params = YAML.load_file('config.yml')

Events / Callbacks
==================

To receive something from an event, you need to call the receive method on the event and pass a block into this method

	tracker.event_name.receive do |params|
		# ...
	end

on_error
--------

is fired when an error occures

	tracker.on_error.receive do |message, trace|
		# print the error message and the stacktrace to STDOUT
		puts message
		puts trace
		# and stop the tracker
		tracker.stop
	end

on_match
--------

is fired wenn an filter matched on an status

	tracker.on_match.receive do |status, filter_path, filter_value|
		puts "filter matched on #{filter_path} with #{filter_value} in status ##{status['id']}"
	end

before_retweet
--------------

is fired before the tracker retweets a status

	tracker.before_retweet.receive do |status|
		# print the status to STDOUT
		puts status
	end

after_retweet
-------------

is fired after the tracker has retweeted a status

	tracker.after_retweet.receive do |status|
		# save the status with active record
		Retweet.new(status)
	end

Filters
=======

You need to configure the *filters_config* in the params and set the path to the YAML file. At the moment this needs to be an YAML file, cause the tracker is reading this file, every time a new status comes in via the client. I decided to read it on each status, cause I don't wanted to restart the Tracker every time I made a change to the filters.

For example we want to filter all tweets with the source "web", we need to define the following line in our *filters.yml*

	"source": "web"

The Tracker checks if the field "source" of the incoming status *includes* OR *is equal* to "web". If you want to filter more than one source, you simply need to write it this way:

	"source": ["web", "TweetDeck"]

You can define all fields inside the status object. You want to filter tweets by me, so you need to define

	"user/screen_name": "gr4y"

You can even filter all tweets of users with an evil background color.

	"user/profile_background_color": "666666"

Contribution
============

Feature Requests / Issues
-------------------------

If you ran into some errors? Then don't be shy and file an issue in the [issue-tracker][4]
Maybe you have a feature request then file an issue too.

Note on Patches/Pull Requests
-----------------------------

You want to add a feature or you want to patch streambot?

1. Fork the project.

2. Make your feature addition or bug fix.

3. Add tests for it. This is important so I don't break it in a future version unintentionally.

4. Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore	when I pull)

5. Send me a pull request. Bonus points for topic branches.

[1]: http://rubygems.org/gems/streambot
[2]: http://rdoc.info/projects/gr4y/streambot
[3]: http://dev.twitter.com
[4]: http://github.com/gr4y/streambot/issues

Copyright
=========

Copyright (c) 2010 Sascha Wessel. See LICENSE for details.
