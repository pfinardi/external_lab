# School laboratory

Settings for school laboratory with Edubuntu Linux clients, local server (apt-mirror, nfs shared folders, backup, ansible):

- copy sources.list template with local mirror server
- install necessary packages: Geogebra, XMind, ...
- uninstall unnecessary packages
- configure scheduled backup on server with rsync on ssh
- set preferences: Trash on desktop, recursive search in Nautilus, ...
- mount shared folder with NFS and show it on desktop
- configure automatic upgrades with unattended-upgrades

---
## Settings

### hosts file
Create file **hosts** (that is ignored by git) with the list of the hosts to mantain with **ansible**. For example:

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
Copy the public ssh key from the server who run *ansible* on any host listed in file **hosts**:
<pre><code>ssh-copy-id -i ~/.ssh/id_rsa.pub (your_user)@(ip-host)</code></pre>

---
## Ansible

### Basic settings
<pre>
ansible-playbook -s 10_basic_settings.yml
</pre>

Tasks (all hosts):

- add server to /etc/hosts file
- sets some preferences:
    - show "Trash" on desktop 
    - enable recursive search in Nautilus file manager
- copy sources.list template with local mirror server in /etc/apt/

### NFS shared folders
mount shared folder with NFS and show it on desktop

<pre>
ansible-playbook -s 20_nfs.yml
</pre>

Tasks (all hosts):

- install **nfs** client packages if needed
- create *mount point* directory
- configure **/etc/fstab** to mount the shared folder and mount it
- set preferences to show shared folder on desktop

### SSH backup on server
<pre>
ansible-playbook -s 30_backup_ssh.yml --extra-vars "labext_pwd=(password_of_user_labext"
</pre>

Configure backup ssh of the clients con server. 

IMPORTANT: run ansible playbook giving the *password* of server user **labext** created before on server.

Tasks (all hosts):

- create SSH key on any hosts
- copy the SSH public key of any hosts on server
- add backup job on **crontab** of any hosts

### Configure unattended-upgrades (automatic upgrades)
<pre>
ansible-playbook -s 40_unattended-upgrades.yml
</pre>

Configure the automatic upgrades with unattended-upgrades


### Install/Remove packages
<pre>
ansible-playbook -s 50_apt.yml
</pre>

Tasks:

- install necessary packages from repository
- install necessary packages with *dpkg*
- remove unnecessary packages
