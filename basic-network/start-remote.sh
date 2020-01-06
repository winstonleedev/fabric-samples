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

scp -r ./crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp peer1:/home/medium/fabric-workdir/msp/peer
scp -r ./crypto-config/peerOrganizations/org1.example.com/users peer1:/home/medium/fabric-workdir/msp/users
scp -r ./config peer1:/home/medium/fabric-workdir/configtx
ssh fabric-ca 'bash -s' < ./remote-bash/peer1-init.sh

scp -r ./crypto-config/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/msp peer2:/home/medium/fabric-workdir/msp/peer
scp -r ./crypto-config/peerOrganizations/org1.example.com/users peer2:/home/medium/fabric-workdir/msp/users
scp -r ./config peer2:/home/medium/fabric-workdir/configtx
ssh fabric-ca 'bash -s' < (cat ./remote-bash/peer1-init.sh | sed -e 's|peer1|peer2|')

scp -r ./crypto-config/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/msp peer3:/home/medium/fabric-workdir/msp/peer
scp -r ./crypto-config/peerOrganizations/org1.example.com/users peer3:/home/medium/fabric-workdir/msp/users
scp -r ./config peer3:/home/medium/fabric-workdir/configtx
ssh fabric-ca 'bash -s' < (cat ./remote-bash/peer1-init.sh | sed -e 's|peer1|peer3|')

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

ssh fabric-ca 'bash -s' < ./remote-bash/peer1-join.sh
ssh fabric-ca 'bash -s' < (cat ./remote-bash/peer2-join.sh | sed -e 's|peer1|peer2|')
ssh fabric-ca 'bash -s' < (cat ./remote-bash/peer2-join.sh | sed -e 's|peer1|peer3|')
