cd ~
rm -rf fabric-samples
rm -rf fabric-workdir
git clone git@github.com:thanhphu/fabric-samples.git
mkdir fabric-workdir

export FABRIC_LOGGING_SPEC=info
export ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
export ORDERER_GENERAL_GENESISMETHOD=file
export ORDERER_GENERAL_GENESISFILE=/home/medium/fabric-workdir/configtx/genesis.block
export ORDERER_GENERAL_LOCALMSPID=OrdererMSP
export ORDERER_GENERAL_LOCALMSPDIR=/home/medium/fabric-workdir/msp/orderer/msp

~/fabric-samples/bin/orderer