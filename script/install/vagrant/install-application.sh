#! /bin/sh

password=`cat /vagrant/script/keys/password_for_private_key`
repo=git@github.com:tarata/dotfiles.git

expect -c "
set timeout -1
spawn git clone $repo
expect \"Are you sure you want to continue connecting (yes/no)?\" {
    send \"yes\n\"
    expect \"Enter passphrase for key '/home/vagrant/.ssh/private_key_for_github':\"
    send \"${password}\n\"
} \"Enter passphrase for key '/home/vagrant/.ssh/private_key_for_github':\" {
    send \"${password}\n\"
}
interact
"

