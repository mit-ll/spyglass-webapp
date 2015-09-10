# Spyglass

Spyglass is a web application with associated components that allow a user to create on-demand
bastion hosts for connecting to a remote private network. This is currently good enough to
demonstrate; pull requests are welcome to add more operational functionality, amongst other 
features.

## Prerequisites 

To begin, you will need the following components:

1. A YubiKey validation server. You could use YubiCloud, however we recommend setting up your own 
   validation server. This is covered in Section 3 of "Demand-Provisioned Linux Containers for
   Private Network Access."
2. An idea of what target OS you want your containers to run. For the demonstration, we used Ubuntu
   14.04 from the Docker Registry.
3. A version of [SudoSH](http://sourceforge.net/projects/sudosh/) compiled for that OS.
4. The scripts used to create the Docker image. These are in the docker-spyglass repository.
5. A MySQL instance

## Setup

1. Clone all associated repositories (in addition to this  repository, get [spyglass-containerd](https://github.com/mitll-cyber/spyglass-containerd), [spyglass-seekerd](https://github.com/mitll-cyber/spyglass-seekerd), [spyglass-dockerfile](https://github.com/mitll-cyber/spyglass-dockerfile).
2. Set up Passenger/Apache (or NGINX) as one would do for a Rails app.
2. Configure settings for this app's `config/database.yml` values
3. Devise needs to be configured for a local validation server if you're not using one. This is done
   in `config/initializers/devise.rb`. Specifically, the strings `config.yubikey_api_id`, 
   `config.yubikey_api_key`, `config.yubikey_api_url` need to be set. A good default for 
   `config.yubikey_certificate_chain` is 
   `Rails.root.join('config','yubikey-validation-cert.crt').to_s` -- but you can change that to 
   whatever certificate location you would like to use to validate your internal YubiKey server.
4. `bundle install` will get all the prereqs in place
5. `RAILS_ENV=production rake db:seed` should initialize the database and set up an initial admin 
    account, with username `admin` and password `admin`.
6. Ensure `containerd` is running in the background
7. If you would like auditing, you may want to look at `seekerd`. This requires the setup of another
   host to capture the audit daemon, and is not as well implemented. Changes to the seeker code 
   are required to not send screen/keyboard input data with every keystroke.
