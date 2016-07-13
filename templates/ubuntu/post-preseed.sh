#!/bin/sh

###
### UbuntuPreseed Post Install Script
### -----------------------------------
### Author : Toshaan Bharvani <toshaan@vantosh.com>
### (c) copyright VanTosh 2013
### BSD License
###


### Go into the machine environment
#TARGET='/target'
#chroot $TARGET

### OpenSSH Settings
/bin/sed 's/\Port\ 22/Port\ {{ ansible_port }}/' -i /etc/ssh/sshd_config
/bin/sed 's/\LoginGraceTime\ 120/LoginGraceTime\ 60/' -i /etc/ssh/sshd_config
/bin/sed 's/\PermitRootLogin\ prohibit\-password/PermitRootLogin\ no/' -i /etc/ssh/sshd_config
/bin/sed 's/UsePAM\ yes/UsePAM\ yes\nAllowUsers\ ansible/' -i /etc/ssh/sshd_config
/bin/sed 's/\#Banner\ \/etc\/issue.net/Banner\ \/etc\/ssh\/banner/' -i /etc/ssh/sshd_config
/bin/sed 's/PrintLastLog\ yes/PrintLastLog\ no' -i /etc/ssh/sshd_config
{#
/usr/bin/ssh-keygen -q -t rsa -b {{ sshdrsakeylength }} -f /etc/ssh/ssh_host_rsa_key -C '' -N ''
/usr/bin/ssh-keygen -q -t ecdsa -b {{ sshdecdsakeylength }} -f /etc/ssh/ssh_host_ecdsa_key -C '' -N ''
/usr/bin/ssh-keygen -q -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -C '' -N ''
#}

### Ansible User
/bin/mkdir /home/ansible/.ssh/
/bin/chmod 700 /home/ansible/.ssh/ ; \
/bin/echo "{{ sshpubkey.content|b64decode }}" > /home/ansible/.ssh/authorized_keys ; \
/bin/chmod 600 /home/ansible/.ssh/authorized_keys ; \
/bin/chown -R 999999.999999 /home/ansible/.ssh/

### Sudo Settings
/bin/cat << 'EOF' > /etc/sudoers.d/ansible
Defaults:ansible !requiretty
ansible     ALL=(ALL)       NOPASSWD: ALL
EOF
/bin/chmod 440 /etc/sudoers.d/ansible

### Delete unnecessary users
/usr/sbin/userdel games
/usr/sbin/userdel list
/usr/sbin/userdel irc
/usr/sbin/userdel proxy
/usr/sbin/userdel backup
/usr/sbin/userdel gnats
/usr/sbin/userdel news

# ssh banner
/bin/cat << 'EOF' > /etc/ssh/banner
+---------------------------------------------------------------------+
|         #     #               #######                               |
|         #     #   ##   #    #    #     ####   ####  #    #          |
|         #     #  #  #  ##   #    #    #    # #      #    #          |
|         #     # #    # # #  #    #    #    #  ####  ######          |
|          #   #  ###### #  # #    #    #    #      # #    #          |
|           # #   #    # #   ##    #    #    # #    # #    #          |
|            #    #    # #    #    #     ####   ####  #    #          |
+---------------------------------------------------------------------+
|   This system is for the use of authorized users only.  Usage of    |
|   this system may be monitored and recorded by system personnel.    |
|   Anyone using this system expressly consents to such monitoring    |
|   and is advised that if such monitoring reveals possible           |
|   evidence of criminal activity, system personnel may provide the   |
|   evidence from such monitoring to law enforcement officials.       |
+---------------------------------------------------------------------+
Press <Ctrl-C> if you do not agree or if you are not an authorized user.
EOF

exit
