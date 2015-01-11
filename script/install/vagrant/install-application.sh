#! /bin/sh

password=`cat /vagrant/script/keys/password_for_private_key`
repo=git@github.com:tarata/expect-command-getting-started.git

expect_message_ssh="Are you sure you want to continue connecting (yes/no)?"
expect_message_key_password="Enter passphrase for key '/home/vagrant/.ssh/private_key_for_github': "

expect -c "
set timeout -1
spawn git clone $repo
expect \"${expect_message_ssh}\" {
    send \"yes\n\"
    expect \"${expect_message_key_password}\"
    send \"${password}\n\"

    expect \"${expect_message_key_password}\" {
        set timeout 1
    } \"*$\";
} \"${expect_message_key_password}\" {
    send \"${password}\n\"
    expect \"${expect_message_key_password}\" {
        set timeout 1
    } \"*$\";
}
"

if [ ! -d $HOME/`basename ${repo%.git}` ]; then
    echo "\n"
    echo "failed to git clone"
fi
