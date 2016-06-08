HOW TO UPDATE THE SAUCELABS SQUID PACKAGE
=========================================

This assumes you run a Debian/Ubuntu system.

    $ git clone git@github.com:saucelabs/squid3.git
    $ cd squid3/

Find the latest version of squid that was imported:

    $ git tag | grep '^squid-'
    squid-3.4.6
    squid-3.5.19
    $ git checkout squid-3.5.*      # DO THIS WITH THE LATEST VERSION

You'll get a warning about a detached head, don't panic, nobody's head ain't
gonna be detached in this operation. We're going to work from the original squid
versions, so that we can merge cleanly against master. If we extracted the squid
tarball directly into the master branch we may overwrite changes that we want to
keep. This will require a bit of git gymnastic.

Download the latest version of squid let's say 3.5.99.

    $ cd ..
    $ wget http://www.squid-cache.org/Versions/v3/3.5/squid-3.5.99.tar.gz
    $ tar zxf squid-3.5.99.tar.gz

We're going to remove everything in the squid3 repo except the .git directory.
It's to make sure that old deleted files get deleted by git:

    $ cd squid3/
    $ rm -rf *
    $ cp -r ../squid-3.5.99/*  .

Now we'll create a new branch to store our changes:

    $ git checkout -b squid-3.5.99

We're going to commit, but first review the changes to make sure the merge good:

    $ git add .     #
    $ git status
    ...
    Diligent review with git diff if needed!
    ...
    $ git commit -m 'Update original to squid-3.5.99'

Now we're have all the changes between the previous version of squid and the
current one, except the deleted files, those will stay around forever untouched
and hopefully useless and harmless... Now let's merge to master:

    $ git checkout master
    $ git merge -m 'Update master to squid-3.5.99' squid-3.5.99

Now we've merge the changes to master, let's try to build the package:

    $ sudo dpkg-buildpackage -B

At that point you'll be asked to install a bunch of dependencies. I recommend
that you cooperate with the computer overlord and install those dependencies:

    $ sudo apt-get install [list of dependencies...]
    $ sudo dpkg-buildpackage -B
    ... FIX STUFF UNTIL IT WORKS ...

The package will be in the ... directory.

Check that the package is A-OK, and commit your changes if there are any:

    $ git commit -m 'Fixes for squid-3.5.99 update'
    $ git push
