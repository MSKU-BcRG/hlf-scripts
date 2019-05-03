#!/bin/bash


if [ $1 = "stop" ]; then
    killall orderer  2> /dev/null
	echo 'Orderer Has Been STOPPED'
	exit 0
fi


# orderer.yaml file path
export FABRIC_CFG_PATH=$PWD/../config

export ORDERER_FILELEDGER_LOCATION=$PWD/.
echo "Orderer is running"
./orderer 2> orderer.log &