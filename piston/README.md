#获取nvm最新版本
nvm ls-remote | grep -v iojs*|sed -n '$p'
#下载nvm最新版本
wget https://github.com/creationix/nvm/archive/master.zip
