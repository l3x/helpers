# Test Paths

This Ruby script will test the **protocols** for the **paths** for the **domains** specified in the .txt files.

In this example, this script verifies that domains have the paths and that they all respond to both http and https.

## Install and Configure

### Ruby
Assumes you've got Ruby installed

```
$ ruby --version
ruby 2.6.1p33 (2019-01-30 revision 66950) [x86_64-linux]
```

### Bundler
You may need to run `gem install bundle`

Run `bundle install` to install the required Ruby gems.


### Text Files

Assumes each .txt file's last line is empty

```
$ S='--------------';find . -name "*.txt" | while read line; do  echo "$S";echo "$line:";echo "$S";cat "$line"; done; echo ''
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

## Running the app

Run the test script as follows:

```
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

### Fails Fast

In this case, we put `google.net` on the second line of domains.txt.

```
$ bundle exec ruby paths_test.rb 
NOTE: `gem install minitest-proveit` for even more hellish tests
Run options: --seed 50971

# Running:

Testing: http://google.com/about
Testing: http://google.com/mail
Testing: http://google.net/about
F

Finished in 0.982859s, 1.0174 runs/s, 3.0523 assertions/s.

  1) Failure:
RedirectsTest#test_paths [paths_test.rb:52]:
Expected: 301
  Actual: 302

1 runs, 3 assertions, 1 failures, 0 errors, 0 skips
```
