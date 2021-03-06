# how to deploy to DO

### (manually)

```unix
$ ssh root@45.55.84.132

Welcome to Ubuntu 14.04.4 [...]

Last login: Sun Sep 25 17:40:45 2016 from [...]
root@coop-shop:~# cd ~rails/Marvl/
root@coop-shop:~# git pull origin master
root@coop-shop:~# bundle install
root@coop-shop:~# . /etc/default/unicorn
root@coop-shop:~# RAILS_ENV=production bundle exec rake db:migrate
root@coop-shop:~# RAILS_ENV=production bundle exec rake db:seed
root@coop-shop:~# service unicorn restart

```

### step by step explanation

>```unix
root@coop-shop:~# cd ~rails/Marvl/
```

* a user named 'rails' "owns" the app on the digital ocean server. change directories from root home to the Marvl directory (`Marvl/`) inside rails user home (`~rails/`).

---

>```unix
root@coop-shop:~# git pull origin master
```

* once you are inside `Marvl/`, it's the same repo that you have on your local machine. pull any new changes from github.

> note: if you need to merge anything, it will open an unfamiliar terminal editor (called nano; see screencap below). to save and exit, type `ctrl-x` and it will disappear

![](/md_assets/getoutofnano.jpg)
---

>```unix
root@coop-shop:~# bundle install
```

* run bundle install in case there are any new gems to install via the Gemfile.

---

>```unix
root@coop-shop:~# . /etc/default/unicorn
```

* on production, the database requires a password (development and test do not have this). this command loads the password into the environment variables from a script hiding in our file system that belongs to the production webserver, which is called `unicorn`.

---

>```unix
root@coop-shop:~# RAILS_ENV=production bundle exec rake db:migrate
```

* migrate the database

---

>```unix
root@coop-shop:~# RAILS_ENV=production bundle exec rake db:seed
```

> **remember**: "NEVER" SEED ON PRODUCTION

* if we're still in development, seed the database. (this would be **BAD** after we have **ANY** real accounts. the real rule is "NEVER SEED ON PRODUCTION." we are only ingnoring it temporarily, until we add the vendor database and we have and are are happy with 1 or 2 seed accounts, etc.)

---

**NEW!**

>```unix
RAILS_ENV=production bundle exec rails assets:precompile
```

* if there are new images, or anything else in the assets pipeline that "should be" showing up but isn't, you need to [precompile the assets](https://www.sitepoint.com/asset-precompile-works-part/).
I don't really know what it means. but it moves some things, renames them, turns scss into css, maybe compresses stuff. Most importantly, it makes the shit show up. No idea why this is automatic on
development but manual on production. when I find out, this step will probably disappear from these instructions.

---

>```unix
root@coop-shop:~# service unicorn restart
```

* now you've made all of the changes. restarting the web server will make them appear on the internet.



You're done!

Quickly check the server [http://45.55.84.132/](http://45.55.84.132/) to eyeball-verify that we have not blown anything up, then log out of root and go have a snack! Good work.
