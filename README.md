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

$sh /vagrant/script/install/vagrant/install-application.sh
```

参考: `/path/to/project/script/install/vagrant/install-application.sh`  
