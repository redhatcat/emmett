Features
--------

* Multiple text formatting options
    * Plain text
    * HTML
    * BBCode
    * Markdown
        * includes syntax highlighting
    * RDoc
    * Textile
* Post previewing for all above markups
* Commenting with Akismet spam filtering
* Tagging
* Publishing lifecycle

Installing
----------

    $ git clone git://github.com/redhatcat/emmett.git
    $ cd emmett
    $ bundle install
    $ rake db:migrate # Assuming you have a emmett_development postgresql db

Getting Started
---------------

1. ./script/server
2. Open a browser and go to http://localhost:8000/
3. You will be prompted to sign up.  This first user will be made an administrator.

[API Documentation](http://redhatcat.github.com/emmett)
