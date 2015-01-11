private_key_for_github=/vagrant/script/keys/private_key_for_github
if [ -f $private_key_for_github ]; then
    mkdir -p $HOME/.ssh
    cp -f $private_key_for_github $HOME/.ssh/
    cp -f /vagrant/script/keys/ssh_config_file $HOME/.ssh/config
    chmod 600 $HOME/.ssh/private_key_for_github
    chmod 600 $HOME/.ssh/config
else
    echo "github用の秘密鍵設定が行われていません"
fi
