# Common Lisp on Heroku -- Example Project

This project is an example of how to use [my fork](https://github.com/jsmpereira/heroku-buildpack-cl) of the [Heroku Common Lisp Buildpack](https://github.com/mtravers/heroku-buildpack-cl).  See the buildpack repository for more information and credits.

## Instructions:
First, get yourself set up with a [Heroku account and tools](http://devcenter.heroku.com/articles/quickstart).

Then [fork this project](/jsmpereira/heroku-cl-example/fork_select) (and optionally modify it with your own content).

Next, create your own Heroku application using CL Buildpack:

    heroku create -s cedar --buildpack http://github.com/jsmpereira/heroku-buildpack-cl.git

Install http://devcenter.heroku.com/articles/labs-user-env-compile to have config vars available at build time.

So you can choose implementation via: ```heroku config:add CL_IMPL={sbcl|ccl}```

To avoid trouble with SBCL source encoding use: ```heroku config:add LANG=en_US.UTF-8```

And deploy:

    git push heroku

That's it!

## More details:

The file heroku-setup.lisp gets loaded at compile time, and needs to load any Lisp files or packages required.  

