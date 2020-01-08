killall -9 orderer
export FABRIC_CFG_PATH="/home/medium/fabric-workdir"
export FABRIC_LOGGING_SPEC=info
export ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
export ORDERER_GENERAL_GENESISMETHOD=file
export ORDERER_GENERAL_GENESISFILE=/home/medium/fabric-workdir/configtx/genesis.block
export ORDERER_GENERAL_LOCALMSPID=OrdererMSP
export ORDERER_GENERAL_LOCALMSPDIR=/home/medium/fabric-workdir/msp/orderer/orderer0.example.com/msp
cd ~/fabric-workdir
nohup ~/fabric-samples/bin/orderer &