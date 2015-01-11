#!/usr/bin/expect
password=`cat /vagrant/script/keys/password_for_private_key`
set timeout -1
spawn git clone git@github.com:tarata/dotfiles.git
expect "Are you sure you want to continue connecting (yes/no)?"
send "yes\n"
expect "Enter passphrase for key '/home/vagrant/.ssh/private_key_for_github':"
send "${password}\n"
expect "#"
