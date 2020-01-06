cd ~
rm -rf fabric-samples
rm -rf fabric-workdir
git clone git@github.com:thanhphu/fabric-samples.git
mkdir fabric-workdir
export FABRIC_CA_HOME=/home/medium/fabric-workdir/fabric-ca-server
export FABRIC_CA_SERVER_CA_NAME=ca.example.com
export FABRIC_CA_SERVER_CA_CERTFILE=/home/medium/fabric-workdir/fabric-ca-server-config/ca.org1.example.com-cert.pem
export FABRIC_CA_SERVER_CA_KEYFILE=/home/medium/fabric-workdir/fabric-ca-server-config/78d60522ea3a86832a3a73a50b2b9ec1ad2795e96ec111457879f303a0fbd46e_sk
~/fabric-samples/bin/fabric-ca-server start -b admin:adminpw