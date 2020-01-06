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

# ssh fabric-ca 'bash -s' < ./remote-bash/common.sh
# rsync -r ./crypto-config/peerOrganizations/org1.example.com/ca fabric-ca:/home/medium/fabric-workdir/fabric-ca-server-config
# ssh fabric-ca 'bash -s' < ./remote-bash/fabric-ca.sh

ssh orderer0 'bash -s' < ./remote-bash/common.sh
rsync -r ./*.yaml orderer0:/home/medium/fabric-workdir/
rsync -r ./config/ orderer0:/home/medium/fabric-workdir/configtx
ssh orderer0 'mkdir -p /home/medium/fabric-workdir/msp/orderer'
rsync -r ./crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com orderer0:/home/medium/fabric-workdir/msp/orderer
rsync -r ./crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/ orderer0:/home/medium/fabric-workdir/msp/peerOrg1
ssh orderer0 'bash -s' < ./remote-bash/orderer0.sh

ssh peer1 'bash -s' < ./remote-bash/common.sh
rsync -r ./core1.yaml peer1:/home/medium/fabric-workdir/core.yaml
ssh peer1 'mkdir -p /home/medium/fabric-workdir/msp/peer'
rsync -r ./crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp/ peer1:/home/medium/fabric-workdir/msp/peer/
rsync -r ./crypto-config/peerOrganizations/org1.example.com/users/ peer1:/home/medium/fabric-workdir/msp/users/
rsync -r ./config peer1:/home/medium/fabric-workdir/configtx
ssh peer1 'bash -s' < ./remote-bash/peer1-init.sh

ssh peer2 'bash -s' < ./remote-bash/common.sh
rsync -r ./core1.yaml peer2:/home/medium/fabric-workdir/core.yaml
ssh peer2 'mkdir -p /home/medium/fabric-workdir/msp/peer'
rsync -r ./crypto-config/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/msp/ peer2:/home/medium/fabric-workdir/msp/peer/
rsync -r ./crypto-config/peerOrganizations/org1.example.com/users/ peer2:/home/medium/fabric-workdir/msp/users/
rsync -r ./config peer2:/home/medium/fabric-workdir/configtx
ssh peer2 'bash -s' < (cat ./remote-bash/peer1-init.sh | sed -e 's|peer1|peer2|')

ssh peer3 'bash -s' < ./remote-bash/common.sh
rsync -r ./core1.yaml peer3:/home/medium/fabric-workdir/core.yaml
ssh peer3 'mkdir -p /home/medium/fabric-workdir/msp/peer'
rsync -r ./crypto-config/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/msp/ peer3:/home/medium/fabric-workdir/msp/peer/
rsync -r ./crypto-config/peerOrganizations/org1.example.com/users/ peer3:/home/medium/fabric-workdir/msp/users/
rsync -r ./config peer3:/home/medium/fabric-workdir/configtx
ssh peer3 'bash -s' < (cat ./remote-bash/peer1-init.sh | sed -e 's|peer1|peer3|')

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

ssh peer1 'bash -s' < ./remote-bash/peer1-join.sh
ssh peer2 'bash -s' < (cat ./remote-bash/peer2-join.sh | sed -e 's|peer1|peer2|')
ssh peer3 'bash -s' < (cat ./remote-bash/peer2-join.sh | sed -e 's|peer1|peer3|')
