export FABRIC_CFG_PATH="/home/medium/fabric-workdir"
cd $FABRIC_CFG_PATH

# Join peer2 & 3to the channel.
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=/home/medium/fabric-workdir/msp/users/Admin@org1.example.com/msp
~/fabric-samples/bin/peer channel join -b mychannel.block