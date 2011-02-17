# GitHub Cloud App

## What is git_cloud?

git_cloud lets you copy files to the cloud and returns a bit.ly link to those
files (copied to your clipboard too). It utilizes git and github for the
file storage but can be configured for other online git repos.

The command basically copies the given file path to your specified repository and runs git add, git commit, and git push on the file. It then returns the bit.ly url that points to its location on the upstream server. The url is also copied to your clipboard.

** Usage **

    $ git_cloud path/to/file/or/folder
    Copied http://bit.ly/XXXXX to your clipboard.

## Configuration

You need to set the following parameters in the ~/.git_cloud.cfg
    GIT_UPSTREAM   = "https://github.com/johndoe/gh_cloud"
    GIT_REPO_ROOT  = "#{ENV['HOME']}/.gh_cloud"
    FOLDER_LAYOUT  = "%Y/%B"
    BITLY_USERNAME = "johndoe"
    BITLY_API_KEY  = "XXXXX"

Create a public repo on GitHub and clone it to your `GIT_REPO_ROOT` path. 

If you want to install this on multiple computers I suggest that you use a different branch for each one to avoid conflicts when pushing.

## Contribute

Make sure your methods are [TomDoc](http://tomdoc.org)'d properly, that existing tests pass (`rake`), and that any new functionality includes appropriate tests.

Then [send me a pull request](https://github.com/wmernagh/git_cloud/pull/new/master)!

## About Me

Find me on Twitter — [@im_a_muppet](http://twitter.com/im_a_muppet) — if you have any issues/comments etc.
