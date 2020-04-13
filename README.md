# Helpers

I'll post scripts, etc., here that are helpful here.

## rmrf
```bash
# Purpose:  A safe way to run rm -rf
# Author:   Lex Sheehan
# License:  MIT
```

### Description

Do you ever have that cringe in your tummy before running **rm -rf**?  Worse yet, the face palm after running it?

![](images/homer-face-palm.png)

I wrote a bash script named **rmrf** that allows me to safely delete directories.  If anybody's interested, I'll make it accessible.  Been using it for years w/o a mistake. BTW - I use rmrf while in the command line  and typically use **rm -rf** in script files.  [Reference](https://twitter.com/lex_sheehan/status/1168634686001897482)



## test_paths

This Ruby script will test the **protocols** for the **paths** for the **domains** specified in the .txt files.

### Description

Ever needed to verify that a list of domains have the paths and that they all respond to both http and https?

### Text Files

Assumes each .txt file's last line is empty

```
--------------
./paths.txt:
--------------
/about
/main
--------------
./protocols.txt:
--------------
http://
https://
--------------
./domains.txt:
--------------
google.com
yahoo.com
microsoft.com
```

### Running the app

Run the test script as follows:

```bash
$ bundle exec ruby paths_test.rb 
NOTE: `gem install minitest-proveit` for even more hellish tests
Run options: --seed 60360

# Running:

Testing: http://google.com/about
Testing: http://google.com/mail
Testing: http://yahoo.com/about
Testing: http://yahoo.com/mail
Testing: http://microsoft.com/about
Testing: http://microsoft.com/mail
Testing: https://google.com/about
Testing: https://google.com/mail
Testing: https://yahoo.com/about
Testing: https://yahoo.com/mail
Testing: https://microsoft.com/about
Testing: https://microsoft.com/mail
.

Finished in 1.939989s, 0.5155 runs/s, 6.1856 assertions/s.

1 runs, 12 assertions, 0 failures, 0 errors, 0 skips
```



## info-github-labels

```bash
# Filename: info-github-labels
# Purpose:  Info about how to label your git branches

Typical github branch labels:

* feature: Adding functionality? (may include tests, fixes, docs, etc.)
* fix    : Fixing bugs. In production use 'hotfix'
* nfr    : Functional Requirement, e.g., configuration
* test   : Adding tests, e.g. unit tests, performance tests, etc.
* docs   : Documentation, which may include design and/or install/config documention
* explore: An exploratory branch, which might get converted to a feature branch

Examples:
feature/add-get-customer-details-use-case
fix/use-correct-exchange-rates
hotfix/change-from-http-to-https
nfr/update-gemfile
test/add-perf-tests-for-fund-distribution
docs/add-wallet-use-cases
explore/try-acme-external-service

Use Tags to:
* Tag a commit with verison #. Ex: git tag -a v1.2.0 -m'v1.2.0 - Added Admin GUI' 9fceb02
* Tag steps in build pipeline. Ex: git tag -a step-03 -m'step 03 - After data migration'

```

When working by yourself, feel free to merge directly into master w/o using branches.

### Feature Branch Based Development

When working with a team you should create feature branches and open a [pull request (PR)](https://help.github.com/en/articles/about-pull-requests) , s.t., others can review your code before merging into the projects' master branch.

Git branches should be small and  short-lived.  

The branch should not exist more than a few days, preferably only a few hours.

The longer you wait to create a PR the more likely extra work will be required to merge it with other(s) work.

If you are a team lead or project manager, do not allow a PR to sit idle; The longer the team waits to merge a PR, the more work you are creating for the person that created it.  Do not allow team members with admin rights to circumvent your source code management process. While it might speed things up for your git admin/developer, the rest of your team will suffer.

The key to making feature branch based development work effectively is to not sit on your branch, i.e., avoid long-lived feature branches.

Only when you merge your feature branch to the master branch you are actually integrating your changes.

You can still use feature toggles, e.g. enabling different code paths for different users in the same deployed code.

### Trunk Based Development

In trunk-based development (TBD), developers always check into one branch, typically the master branch a/k/a the "trunk".

While TBD enables instant, continuous integration, however TBD:

* Leads to excessive use of feature toggles, which leads to code complexity
* Circumvents that PR code review process
* Requires an exhaustive suite of tests that are run prior to merging changes to master

TBD fosters more of a "get it out now" rather than a "quality control" mentality.

DevOps tends to like TDB better than Product Owners, Stakeholders, Architects and Developers.



## math

Evaluate simple math expressions on the command line.

Parenthesis are not supported, but you can use `$(expression)`with operators (+, -, *, /).

### Examples

80 laps in a Jr. Olympic swimming pool is a mile.

2.5 miles is 200 laps.  (2 miles + 1/2 mile.)

```bash
$ math 80*2
160

$ math 80*2+$(math 80/2)
200.00000000000000000000
```



## run-ruby-code

Evaluate ruby code from the terminal.

### Examples

If I plan to swim 1 lap, then 2 laps, then 3 laps.. (and back down)... 3 laps, 2 laps, 1 lap.... 

How many laps in my largest set if I want to swim at least 2.5 miles?

```bash
$ run-ruby-code "s=0;(1..14).each{|i| s+=i};puts s*2"
210
```



## find-lastest

Find the most recently updated file in a directory.

Return most recently updated filename if no DIR passed, else full path.

Recurses the directory unless you pass the -maxdepth argument.

### Examples

Return file name only for current directory if no DIR passed.

```bash
~/Downloads $ find-latest
goland-2019.3.3.tar.gz
```

Return file name only for current directory if no DIR passed.

```bash
~ $ find-latest ~/Downloads/
/home/lex/Downloads/goland-2019.3.3.tar.gz
```



## build-and-load-gem-groups

This script allows you to bundle gems for your application based on groups in your Gemfile. (That's the "build" portion of this script.)

This script also allows you to test your rails environments based on RAILS_GROUPS. (That's the "load-gem-groups" portion).

This script can work with the default Bundler configuration for a generated Rails app in the **config/application.rb** file:

```ruby
if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end
```

``` 
Usage: build-and-load-gem-groups [-i group names] | [-e group names] | [-a] | [-d] | [-l] | [-r]

Options:
	-i or --include:		[Optional] groups to include in build and load
	-e or --exclude:		[Optional] groups to exclude in build and load
	-a or --all-groups:		[Optional] include all groups in build and load
	-d or --display-groups:	[Optional] display all groups in Gemfile
	-r or --reset           [Optional] resets bundler and gemfile settings
	-l or --load-path       [Optional] display Ruby load path

Examples:
build-and-load-gem-groups -i 
build-and-load-gem-groups -i assets
build-and-load-gem-groups -e production ci deploy
SKIP_BUILD=true build-and-load-gem-groups -i development
SKIP_LOAD=true build-and-load-gem-groups -i production
LOAD_ENV_PATH=./scripts/load-env.rb  build-and-load-gem-groups -i development

Notes:
* A better, albeit longer name of this script: 'build_and_time_the_loading_of_gem_groups'
* - If group passed 'test' then 'rake rspec' will be run otherwise run load_environment.rb.
* In practice, you should set the RAILS_GROUPS before you run your Ruby code. [Optional] 
* Set env var SKIP_BUILD=true to skip the build portion of this script. [Optional] 
* Set env var SKIP_LOAD=true to skip the load portion of this script. [Optional] 
* Set env var LOAD_ENV_PATH='path to where load_environment.rb path. [Optional] 
* Run 'bundle info <GEM_NAME>' for info about installed gem. Ex: $ bundle info json
* Running $ build-and-load-gem-groups -i assets  fails to load the rails environment as expected 
    because will likely be missing gems required to load a full rails environment.
* Running $ build-and-load-gem-groups -i development  when RAILS_ENV=production may fail with:
  'cannot load such file -- uglifier'  
  'cannot load such file -- scruffy'  
  'cannot load such file -- newrelic_rpm'
  That is expected. In order to build a development package in production you must run:
  $ build-and-load-gem-groups -i development app assets production
* Just because you can do something, does not mean you _should_ do it.
```

### Examples

#### Generic use of bundle command

When running `bundle install` it takes ***25.025s** to load the Rails environment.

```bash
$ export RAILS_ENV=development && build-and-load-gem-groups -r && bundle install && build-and-load-gem-groups -t
The git source https://github.com/sr/shout-bot.git is not yet checked out. Please run `bundle install` before trying to start your application
Fetching https://github.com/RepoName/example_elastic
Fetching https://github.com/RepoName/notification-dispatch
Fetching https://github.com/rails/prototype_legacy_helper
. . .
Resolving dependencies...........................
RubyGems 1.8.23.2 is not threadsafe, so your gems will be installed one at a time. Upgrade to RubyGems 2.1.0 or higher to enable parallel gem installation.
Using rake 0.9.6
Using 12_hour_time 0.0.4
Using Ascii85 1.0.3
. . .
Using verhoeff 2.1.0
Using will_paginate 3.2.1
Using xml-simple 1.1.5
Bundle complete! 128 Gemfile dependencies, 209 gems now installed.
Gems in the groups Missing, Gemfile!, gui and deploy were not installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
Loading Rails environment...
boot.rb - Rails 3.2
/home/lex/.rbenv/versions/1.9.3-p551/lib/ruby/gems/1.9.1/gems/json_pure-1.4.6/lib/json/common.rb:2:in `<top (required)>': iconv will be deprecated in the future, use String#encode instead.
/home/lex/.rbenv/versions/1.9.3-p551/lib/ruby/gems/1.9.1/gems/12_hour_time-0.0.4/lib/12_hour_time/action_view_helpers.rb:3: warning: already initialized constant POSITION
DEPRECATION WARNING: The factory_girl gem is deprecated. Please upgrade to factory_bot. See https://github.com/thoughtbot/factory_bot/blob/v4.9.0/UPGRADE_FROM_FACTORY_GIRL.md for further instructions. (called from <top (required)> at /home/lex/Clients/Example/dev/example_22379_startup/config/application.rb:7)
Please configure your rails_lts_options using config.rails_lts_options inside Rails::Initializer.run. Defaulting to "rails_lts_options = { :default => :compatible }". See https://makandracards.com/railslts/16311-configuring-rails-lts for documentation.
DEPRECATION WARNING:
Sass 3.5 will no longer support Ruby 1.9.3.
Please upgrade to Ruby 2.0.0 or greater as soon as possible.

Rails.groups: [:default, "development"]

real	0m25.025s
user	0m23.368s
sys	0m1.077s

```

#### Use script to bundle gems and RAILS_GROUP when loading enviornment

When running `build-and-load-gem-groups -i` it takes **17.326s** to load the Rails enviroment.

That's a 30% improvement in performance.

```bash
$ export RAILS_ENV=development && build-and-load-gem-groups -r && build-and-load-gem-groups -i 
INCLUDES: development
EXCLUDES: app assets ci deploy test
>> Build groups_to_exclude=app assets ci deploy test
The git source https://github.com/sr/shout-bot.git is not yet checked out. Please run `bundle install` before trying to start your application
Fetching https://github.com/RepoName/example_elastic
Fetching https://github.com/RepoName/notification-dispatch
Fetching https://github.com/rails/prototype_legacy_helper
. . .
Using uuid 2.3.9
Using will_paginate 3.2.1
Using xml-simple 1.1.5
Bundle complete! 128 Gemfile dependencies, 160 gems now installed.
Gems in the groups app, assets, ci, deploy, test, Missing, Gemfile! and gui were not installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
SKIP_BUILD: 
SKIP_LOAD: 

--------------------------------------------------------
 RAILS_GROUPS=development
--------------------------------------------------------
Loading Rails environment...
boot.rb - Rails 3.2
/home/lex/.rbenv/versions/1.9.3-p551/lib/ruby/gems/1.9.1/gems/json_pure-1.4.6/lib/json/common.rb:2:in `<top (required)>': iconv will be deprecated in the future, use String#encode instead.
/home/lex/.rbenv/versions/1.9.3-p551/lib/ruby/gems/1.9.1/gems/12_hour_time-0.0.4/lib/12_hour_time/action_view_helpers.rb:3: warning: already initialized constant POSITION
DEPRECATION WARNING: The factory_girl gem is deprecated. Please upgrade to factory_bot. See https://github.com/thoughtbot/factory_bot/blob/v4.9.0/UPGRADE_FROM_FACTORY_GIRL.md for further instructions. (called from <top (required)> at /home/lex/Clients/Example/dev/example_22379_startup/config/application.rb:7)
Please configure your rails_lts_options using config.rails_lts_options inside Rails::Initializer.run. Defaulting to "rails_lts_options = { :default => :compatible }". See https://makandracards.com/railslts/16311-configuring-rails-lts for documentation.
Rails.groups: [:default, "development"]

real	0m17.326s
user	0m16.309s
sys	0m0.947s
```
