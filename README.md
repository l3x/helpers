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

