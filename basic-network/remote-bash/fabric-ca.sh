# sudo snap install go --classic
/snap/bin/go get -u github.com/hyperledger/fabric-ca/cmd/...

export FABRIC_CA_HOME=/home/medium/fabric-workdir/fabric-ca-server
export FABRIC_CA_SERVER_CA_NAME=ca.example.com
export FABRIC_CA_SERVER_CA_CERTFILE=/home/medium/fabric-workdir/fabric-ca-server-config/ca.org1.example.com-cert.pem
export FABRIC_CA_SERVER_CA_KEYFILE=/home/medium/fabric-workdir/fabric-ca-server-config/813ae7d02f183ca6da1821544e4625c28e717dea659bcc5fd5d54880b6f22b35_sk

nohup fabric-ca-server start -b admin:adminpw &