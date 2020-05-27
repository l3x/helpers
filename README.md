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
Usage: build-and-load-gem-groups [-i group names] | [-e group names] | [-a] | [-d] | [-l] | [-r] | [-t]

Options:
	-i or --include             Groups to include in build and load
	-e or --exclude             Groups to exclude in build and load
	-a or --all-groups          Include all groups in build and load
	-d or --display-groups      Display all groups in Gemfile
	-r or --clear-all           Clear bundler and gemfile settings and remove vendor dir
	-t or --test-load-time      Display how long it takes to load
	-l or --show-load-path      Display Ruby load path
	-c or --show-bundle-config  Display bundle config file contents
	-s or --save-config         Currently only saves Gemile.lock file
	-g or --last-gem-lock-file  Display path of last saved Gemile.lock file
	
	
Examples:
build-and-load-gem-groups -i app development
build-and-load-gem-groups -i app test
build-and-load-gem-groups -i app production
build-and-load-gem-groups -i assets
build-and-load-gem-groups -i deploy
RAILS_GROUPS=development build-and-load-gem-groups -t
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
* If you see an error like the following, then install the test group passing '-i test'
  'cannot load such file -- shoulda/matchers'
* If you see an error like the following after an --i operation, then install it's group
  'cannot load such file -- ruby-hl7'
  Assming its group is 'app', then run 'build-and-load-gem-groups -i test app'
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

#### Use script to bundle gems and RAILS_GROUP when loading Rails environment

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

#### Display groups from Gemfile

This script makes use of Rails groups to bundle and load Rails environments.

This will show you the groups you currently have defined in your Gemfile:

``` 
$ script/build-and-load-gem-groups -d
app
assets
ci
deploy
development
test
```

## git-changes

I wrote this script out of shear frustation.

It seems that I have a super power that allows me to find new ways to delete my work with git.

The irony is that git is supposed to help save and version your work, but every now and then after running a git command some of my work gets deleted and it's super frustrating.

Never again!

Before running any git command that can modify any file in my workspace, I run the following

### Show new file changes

`git-changes -d` shows me what files I have modified and added on my feature branch. 

The last line of output will the commit id that I use on the next backup command.

### Save my file changes

`git-changes -b BACKUP_FROM_COMMIT_NO` saves my changes. You can change the default backup directory in 1st line of script:

`root_dir=$HOME/REPOs/git-changes$HOME/REPOs/git-changes`


```
Usage: git-changes [-b <BACKUP_FROM_COMMIT_NO>] [-c] [-d] [-r <UPSTREAM_BRANCH>] [-n]

Options:
	-d or --display-changes      Displays all commits since starting this branch (ends with previous commit hash)
	-b or --backup-from-commit   Backup new/changed files in current branch (pass previous commit hash from -d)
	-c or --compare-with-backup  Compare changed files in workspace with those in backup directory
	-r or --rollback-changes     Remove commits after BACKUP_FROM_COMMIT_NO (keeps your changes in your workspace)
	-n or --copy-back-new-files  Restore changed (new) files that you previously backed up
	
Examples:
git-changes -d
git-changes -b 2ed491b41b
git-changes -c 
git-changes -r 
git-changes -n
git-changes -b 2ed491b41b -r
git-changes -b 2ed491b41b -r -n

Notes:
* For details, run one of the following commands:
git log --pretty=one-line
git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative
git log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --numstat
git log --graph --pretty=format:'%C(yellow)%h%Creset%C(cyan)%C(bold)%d%Creset %C(cyan)(%cr)%Creset %C(green)%ce%Creset %s'
```


## find-rename-recursive

This script was inspired from https://stackoverflow.com/questions/9393607/find-and-replace-filename-recursively-in-a-directory


### Begin with these files in this directory structure
``` 
$ . tmp-make-dirs
$ ~/tmp/tmp.i9st1ZcHIn $ tree --dirsfirst
.
├── 123_u
│   ├── 123_a.txt
│   ├── 123_b.txt
│   ├── exclude.me
│   ├── foo_123bar_123_d.txt
│   └── foo_123_c.txt
├── u
│   ├── 123_a.txt
│   ├── 123_b.txt
│   ├── exclude.me
│   ├── foo_123bar_123_d.txt
│   └── foo_123_c.txt
├── 123_a.txt
├── 123_b.txt
├── exclude.me
├── foo_123bar_123_d.txt
└── foo_123_c.txt

2 directories, 15 files
```
Now that files are in place, run the following command to recursively replace all file names that begin with '123_' with the same file name less the '123_'. 

The '--' separates the command options from the positional arguments.  The positional arguments are the arguments that you'd pass to a typical find command.

```
lex@s76 ~/tmp/tmp.kJzgPFEIQe $ find-rename-recursive --pattern '123_' --string '' -- . -type f -name "123_*"
lex@s76 ~/tmp/tmp.kJzgPFEIQe $ tree --dirsfirst
.
├── 123_u
│   ├── a.txt
│   ├── b.txt
│   ├── exclude.me
│   ├── foo_123bar_123_d.txt
│   └── foo_123_c.txt
├── u
│   ├── a.txt
│   ├── b.txt
│   ├── exclude.me
│   ├── foo_123bar_123_d.txt
│   └── foo_123_c.txt
├── a.txt
├── b.txt
├── exclude.me
├── foo_123bar_123_d.txt
└── foo_123_c.txt

2 directories, 15 files
```

### All Other Solutions Break

All other solutions thus far either don't work for me and/or delete files with the sample I tried.


#### Failure 1
This solution just does not work:
```
lex@s76 ~/tmp/tmp.i9st1ZcHIn $ find -name "123*.txt" -exec rename 's/^123_//' {} ";" 
lex@s76 ~/tmp/tmp.i9st1ZcHIn $ tree --dirsfirst
.
├── 123_u
│   ├── 123_a.txt
│   ├── 123_b.txt
│   ├── exclude.me
│   ├── foo_123bar_123_d.txt
│   └── foo_123_c.txt
├── u
│   ├── 123_a.txt
│   ├── 123_b.txt
│   ├── exclude.me
│   ├── foo_123bar_123_d.txt
│   └── foo_123_c.txt
├── 123_a.txt
├── 123_b.txt
├── exclude.me
├── foo_123bar_123_d.txt
└── foo_123_c.txt

2 directories, 15 files
```

#### Failure 2
This solution does not work recursively:
```
lex@s76 ~/tmp/tmp.Zg0G3AVCI9 $ rename 's/^123_//' *.txt
lex@s76 ~/tmp/tmp.Zg0G3AVCI9 $ tree --dirsfirst
.
├── 123_u
│   ├── 123_a.txt
│   ├── 123_b.txt
│   ├── exclude.me
│   ├── foo_123bar_123_d.txt
│   └── foo_123_c.txt
├── u
│   ├── 123_a.txt
│   ├── 123_b.txt
│   ├── exclude.me
│   ├── foo_123bar_123_d.txt
│   └── foo_123_c.txt
├── a.txt
├── b.txt
├── exclude.me
├── foo_123bar_123_d.txt
└── foo_123_c.txt

```


#### Failure 3
This solution works recursively when dirname does not include pattern, but DELETES FILES!
```
lex@s76 ~/tmp/tmp.xdK0oKW19B $ find . -name '123_*.txt'|awk '{print "mv "$0" "gensub(/\/123_(.*\.txt)$/,"/\\1","g");}'|sh
lex@s76 ~/tmp/tmp.xdK0oKW19B $ tree --dirsfirst
.
├── 123_u
│   ├── exclude.me
│   ├── foo_123bar_123_d.txt
│   └── foo_123_c.txt
├── u
│   ├── a.txt
│   ├── b.txt
│   ├── exclude.me
│   ├── foo_123bar_123_d.txt
│   └── foo_123_c.txt
├── a.txt
├── b.txt
├── exclude.me
├── foo_123bar_123_d.txt
└── foo_123_c.txt

2 directories, 13 files
lex@s76 ~/tmp/tmp.xdK0oKW19B $ # <= Is recursive when dirname does not include pattern, but DELETES FILES!
```

# Notes

There are some scripts that don't have info in this README.md file.