cd ~
rm -rf fabric-samples
rm -rf fabric-workdir
export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
git clone https://github.com/thanhphu/fabric-samples.git
mkdir fabric-workdir
