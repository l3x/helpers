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

## Running the app

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
