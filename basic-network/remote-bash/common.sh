cd ~
rm -rf fabric-samples
rm -rf fabric-workdir
export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
export PATH=$GOPATH/src/github.com/hyperledger/fabric/build/bin:${PWD}/../bin:/home/medium/fabric-workdir:$PATH
export FABRIC_CFG_PATH=/home/medium/fabric-workdir
export CHANNEL_NAME=mychannel
# git clone https://github.com/thanhphu/fabric-samples.git
curl -sSL http://bit.ly/2ysbOFE | bash -s -- 1.4.4 1.4.4 0.4.18
mkdir fabric-workdir
