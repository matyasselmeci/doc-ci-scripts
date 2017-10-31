Travis-CI Documentation Scripts
===============================

This repository contains common files and scripts for verification and deployment of OSG documentation using GitHub Pages. This repository is intended to be used as a submodule of your documentation (parent) repository.

Getting started
---------------

1. From the directory containing your parent repository

        $ git submodule add https://github.com/opensciencegrid/doc-ci-scripts ci

1. Check the newly created `ci` directory for contents. If it's empty, run the following to pull down the latest commit from this repository:

        $ git submodule update --init --recursive

1. From the root directory of your parent repository, copy the template to your travis configuration:

        $ cp ci/travis.template.yml .travis.yml
        $ cp ci/travis.template.env .travis.env

    Follow the instructions in the comments of [the environment file](travis.template.env) to customize Travis-CI for the parent repostiry. Merge in any local customizations from your existing `.travis.yml` file to the template.

See the [docs repository](https://github.com/opensciencegrid/docs/) for an example [.travis.yml](https://github.com/opensciencegrid/docs/blob/master/.travis.yml) and [.travis.env](https://github.com/opensciencegrid/docs/blob/master/.travis.yml).

Updating your submodule
-----------------------

To update the submodule yourself, perform the following procedure:


1. `cd` into the `ci` directory
1. Checkout the commit or tag that you're interested in. To update to the latest commit from `master`, run the following command:

        $ git pull origin master

1. `cd` back to the root of your parent repository.
1. Verify that you've updated the submodule repository correctly. The following command will list the commits that have been applied to the submodule repository:

        $ git diff --submodule

1. Commit, push, and perform pull requests as normal

Setting up an ITB repository
----------------------------

_Coming soon..._

