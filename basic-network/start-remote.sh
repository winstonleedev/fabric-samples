#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -ev

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

scp -r ./crypto-config/peerOrganizations/org1.example.com/ca fabric-ca:/home/medium/fabric-workdir/fabric-ca-server-config
ssh fabric-ca 'bash -s' < ./remote-bash/fabric-ca.sh

scp -r ./config/ orderer0:/home/medium/fabric-workdir/configtx
scp -r ./crypto-config/ordererOrganizations/example.com/orderers/orderer0/ orderer0:/home/medium/fabric-workdir/msp/orderer
scp -r ./crypto-config/peerOrganizations/org1.example.com/peers/peer1/ orderer0:/home/medium/fabric-workdir/msp/peerOrg1
ssh fabric-ca 'bash -s' < ./remote-bash/orderer0.sh


# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

# Create the channel
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" peer1 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/channel.tx
# Join peer1 to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" peer1 peer channel join -b mychannel.block
