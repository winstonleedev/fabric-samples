export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp
~/fabric-samples/bin/peer channel create -o orderer0:7050 -c mychannel -f /home/medium/fabric-workdir/configtx/channel.tx

# Join peer1 to the channel.
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=/home/medium/fabric-workdir/msp/users/Admin@org1.example.com/msp
~/fabric-samples/bin/peer channel join -b mychannel.block