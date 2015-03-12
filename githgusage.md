WILLIAM: I'm going to migrate this project to github, since everybody working on it prefers git anyways:   https://github.com/williamstein/psage


# Introduction #

Some people prefer git and its branch architecture to handle the purplesage source code. We describe how to install and work with git-hg.

# Details #

Instead of cloning purplesage with hg we will use the git-hg clone command to fetch our copy.

Install git-hg located at http://offbytwo.com/git-hg/ into any place that you like. /opt and /use/local seem like two good choices on Linux. Make sure that the binary is in your PATH or provide a symbolic link.

We are ready to clone purplesage. Simply type

git-hg clone https://purplesage.googlecode.com/hg/ purplesage

git-hg will do the following: It will create a new git repository. Within a separate folder, that is not under version control it will clone the hg repository using hg.  Then it will import all commits from hg to the git repository.

You can now work with your git repository as if the purplesage code was under git revision control. Indeed, you will find a special remote branch that corresponds to the hg repository.

Only before you push the repository and after you have pull the purplesage code from Google codes you need to type

git-hg pull

or

git-hg push