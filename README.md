# Sinatra Openshift Nginx Redis

An [OpenShift](https://www.openshift.com/) [QuickStart](https://www.openshift.com/quickstarts) for [Ruby](https://www.ruby-lang.org/en/) + [Sinatra](http://www.sinatrarb.com/) + [Nginx](http://nginx.org/en/) + [Redis](http://redis.io/)

By John Mark Schofield (<a href="mailto:jms@schof.org">jms@schof.org</a>) for [Citrusbyte, LLC](https://citrusbyte.com/).


## Thanks
* This QuickStart is based in part on the [OpenShift Sinatra Example](https://github.com/openshift/sinatra-example).
* To add Redis to our OpenShift Gear, I use the [Redis OpenShift Cart](https://github.com/smarterclayton/openshift-redis-cart).
* This QuickStart is based on the [OpenShift "DIY" cartridge](https://github.com/openshift/origin-server/tree/master/cartridges/openshift-origin-cartridge-diy/README.md).
* The Sinatra / Nginx / Unicorn config is based on [http://recipes.sinatrarb.com/p/deployment/nginx_proxied_to_unicorn](http://recipes.sinatrarb.com/p/deployment/nginx_proxied_to_unicorn).
* I used additional information on setting up Nginx on OpenShift from here: [https://www.openshift.com/blogs/lightweight-http-serving-using-nginx-on-openshift](https://www.openshift.com/blogs/lightweight-http-serving-using-nginx-on-openshift).
* I use [rbenv](http://rbenv.org/) to install a more-modern version of Ruby than OpenShift provides.
* It's awesome that [Citrusbyte](https://citrusbyte.com/) paid me to work on this. (We're hiring, and it's a great place to work.)

## Introduction
This readme takes you from absolute zero (a plain-vanilla OS X installation) to having your first OpenShift application up and running. If your system is set up for OpenShift or for Ruby development in OS X, you'll be able to skip some or all of these steps.

These steps have been tested with a fresh install of OS X Mavericks 10.9.2.

You can view a running version of this code at [http://sonr-schof.rhcloud.com/](http://sonr-schof.rhcloud.com/).

## Pre-Requisites
1. You will need an OpenShift account. Create one at [https://www.openshift.com/app/account/new](https://www.openshift.com/app/account/new). If you already have an OpenShift account, verify that you can log in: [https://openshift.redhat.com/app/login](https://openshift.redhat.com/app/login).
2. You will need [rbenv](http://rbenv.org/) installed on your OS X computer. If it's already installed, skip this step. If not, we recommend the following:
    First, install [Homebrew](http://brew.sh/):

    ```
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    ```
    Follow the instructions from the Homebrew installer. (Including the "brew doctor" step it recommends at the end.) Once you've got Homebrew installed and working, you'll need to install rbenv:

    ```
    brew install rbenv ruby-build
    echo eval "$(rbenv init -)" >> ~/.profile
    source ~/.profile
    ```

3. Now, rbenv should be installed. Next we'll need to install the version of Ruby we're going to use:
    ```
    rbenv install 1.9.3-p545
    ```

    This will take a while. Next, we need to tell rbenv to use 1.9.3-p545 in our current shell:
    ```
    rbenv shell 1.9.3-p545
    ```

4. You will need SSH keys generated on your system. If you have already done this, you can skip this step. Otherwise:
```
ssh-keygen -t rsa -C "YOUREMAIL@example.com"
```
Hit enter to accept all the defaults, but **DO** put in a complex password/passphrase. Do not leave it blank.




## RHC Installation
1. You should be using rbenv and have Ruby 1.9.3-p545 active. (Do "ruby --version" to verify.)

```
gem install rhc
rbenv rehash
rhc setup
```
Enter your RedHat OpenShift username and password. Enter "Yes" to generate a token. Upload your key and accept the defaults.


## Creating an OpenShift Application
Now you're ready to create your application and add the Redis cartridge! (Replace APPNAME with the desired name of your application.)

```
rhc app create APPNAME diy-0.1 http://cartreflect-claytondev.rhcloud.com/reflect?github=smarterclayton/openshift-redis-cart
cd APPNAME
git remote add github -f https://github.com/citrusbyte/SONR.git
git merge github/master -s recursive -X theirs
git push origin master
```

That last step will take a LOOOOOOOOONG time, as you're compiling Ruby and Nginx on your OpenShift gear.

The "rhc app create" command should have output the URL to access your application via the web.

## Updating Your OpenShift Application

Now let's make a trivial change just to see how the process works. Edit app.rb and in the "/" stanza, change the first line to "The time where this OpenShift server lives is" -- add the word "OpenShift".

Now do the following:
```
git add app.rb
git commit -m "Adding a description of the server"
git push origin master
```

Reload the page and you'll see your updated server description.
