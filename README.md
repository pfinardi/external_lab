# external_lab
Settings for school laboratory with Edubuntu Linux.

- configure sources.list with internal mirror server
- install package necessary: Geogebra, XMind, ...
- uninstall unnecessary package
- configure scheduled backup on a server with rsync on ssh
- set preferences: Trash on desktop, recursive search in Nautilus, ...
- configure mount to shared folder with NFS and show it on desktop
- configure unattended-upgrades

## To Do

### ...on any hosts
<pre><code>sudo apt-get install openssh-server</code></pre>

### ... on the PC who execute **ansible**
<pre><code>ssh-copy-id -i ~/.ssh/id_rsa.pub riservato@<ip-host></code></pre>
