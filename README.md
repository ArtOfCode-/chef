# `chef`: The Student Chef
Recipes for students, served in a homemade web app.

-----

## Setup
Want to use this for yourself? Go for it! Here's some commands that you're going to need to run:

    git clone https://github.com/ArtOfCode-/chef
    cd chef
    bundle install
    rails db:create
    rails db:schema:load
    rails db:migrate
    rails db:seed
    rails assets:precompile
    rails s -e production

Make sure you're using Ruby > 2.2.2 and Rails 5.0.0.

If you're trying to launch this on a production server, visible to the general Internet rather than just on local, you
*may* need to bind to the machine's LAN IP explicitly. This is usually of the form `192.168.xxx.xxx` or `172.xxx.xxx.xxx`.
Bind the server to this using the `-b` switch:

    rails s -b 192.168.0.20 -e production
