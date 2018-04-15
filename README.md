# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
        $ sudo -u postgres createuser todouser
        $ sudo -u postgres createdb tododb
        $ sudo -u postgres psql
        psql=# alter user todouser with encrypted password '****';
        psql=# grant all privileges on database tododb to todouser;


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
