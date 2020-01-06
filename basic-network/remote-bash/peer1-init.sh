
export CORE_PEER_ID=peer1
export FABRIC_LOGGING_SPEC=info
export CORE_CHAINCODE_LOGGING_LEVEL=info
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=/home/medium/fabric-workdir/msp/peer/
export CORE_PEER_ADDRESS=peer1:7051
cd ~/fabric-workdir
nohup ~/fabric-samples/bin/peer node start &