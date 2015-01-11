expectコマンドを試してみた。
===

## 概要

`vagrant up` 実行時に個人のレポジトリを、httpsではなくsshで、自動的にvagrantユーザにインストールする。
今回の対象は https://github.com/tarata/dotfiles

## 準備

githubに登録した公開鍵に対応する秘密鍵を `/path/to/project/script/keys/private_key_for_github` においてください。  
秘密鍵にパスワードを設定している場合、`/path/to/project/script/keys/password_for_private_key` に記述してください。

```
yum install -y expect
```

参考: `/path/to/project/script/install/root/common.sh`  



## やること

`repo`は適宜個人のレポジトリに置き換えてください

```
$cat /vagrant/script/install/vagrant/install-application.sh

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
"

$sh /vagrant/script/install/vagrant/install-application.sh
```

参考: `/path/to/project/script/install/vagrant/install-application.sh`  
