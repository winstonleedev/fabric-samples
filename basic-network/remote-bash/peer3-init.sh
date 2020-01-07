
export CORE_PEER_ID=peer3
export FABRIC_LOGGING_SPEC=info
export CORE_CHAINCODE_LOGGING_LEVEL=info
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=/home/medium/fabric-workdir/msp/peer/
export CORE_PEER_ADDRESS=peer3:7051
cd ~/fabric-workdir
nohup ~/fabric-samples/bin/peer node start &