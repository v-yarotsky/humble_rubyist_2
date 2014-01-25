Multi-user deployments with Capistrano
======================================

So, the day has come. Your boss wants to know not only why production broke, but also _who_ is responsible.
But how you could possibly find this out? Everyone is represented by the famous 'deployer' on your server...

The solution is to create separate system users in a dedicated group. Simple and elegant. Or is it?

<!-- more -->

Let's create the group and users:

```
groupadd deployers
useradd --create-home --groups deployers <user_a>
useradd --create-home --groups deployers <user_b>
```

I prefer not to set passwords for such users. It effectively prevents login by password.
Generally, you want to restrict access to the server. It can be done by adding some configuration for sshd (/etc/ssh/sshd_config):

```
PasswordAuthentication no
PubkeyAuthentication yes

AllowGroups deployers
```

*DANGER ZONE*: You can as well mess up your server, be cautious!

You'll need to restart sshd for changes to be applied.

So, what's next?

And here goes the interesting part: you'll need your deployment assets to be co-owned by newly created deployers.

1) Create a directory for deployments (`deploy_to` in terms of capistrano).
2) Add group-write permissions and [setgid](http://en.wikipedia.org/wiki/Setuid#setgid_on_directories) on `deploy_to`
   This will make `deploy_to` and all **newly created** nested files/directories inherit group-write permissions.

- DEPLOYER, role :app, role :all, %W{#{fetch(:deployer)}@host}
- tmp_dir
- bundler hardcoded permissions and require 'capistrano/file-permissions'
- how to avoid file-permissions fix with umask

