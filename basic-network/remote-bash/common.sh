cd ~
rm -rf fabric-samples
rm -rf fabric-workdir
export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
# git clone https://github.com/thanhphu/fabric-samples.git
curl -sSL http://bit.ly/2ysbOFE | bash -s -- 1.4.4 1.4.4 0.4.18
mkdir fabric-workdir
