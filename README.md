# external_lab
Settings for school laboratory with Edubuntu Linux.

- configure sources.list with internal mirror server
- install package necessary: Geogebra, XMind, ...
- uninstall unnecessary package
- configure scheduled backup on a server with rsync on ssh
- set preferences: Trash on desktop, recursive search in Nautilus, ...
- configure mount to shared folder with NFS and show it on desktop
- configure unattended-upgrades

## Settings

### hosts file
Make file **hosts** (that is ignored by git) with the list of the hosts to provision with **ansible**. For example:

<pre>
[defaults]

[lab36]
192.168.150.150 ansible_ssh_user=(your_user)
192.168.150.151 ansible_ssh_user=(your_user)
192.168.150.152 ansible_ssh_user=(your_user)
...

[lab37]
192.168.150.176 ansible_ssh_user=(your_user)
192.168.150.177 ansible_ssh_user=(your_user)
192.168.150.178 ansible_ssh_user=(your_user)
...
</pre>


### ...on any hosts
Install **openssh** on any host listed in file **hosts**:
<pre><code>sudo apt-get install openssh-server</code></pre>

### ...on the server who execute ansible
Copy the public ssh key from the server who execute *ansible* on any host listed in file **hosts**:
<pre><code>ssh-copy-id -i ~/.ssh/id_rsa.pub (your_user)@ip-host></code></pre>
