#!/bin/bash

export FABRIC_CFG_PATH=../config

mkdir -p artifacts
# Genesis Block
./configtxgen -profile EnergyOrdererGenesis -outputBlock ./artifacts/energy-genesis.block -channelID ordererchannel

# Channel
./configtxgen -profile EnergyChannel -outputCreateChannelTx ./artifacts/energy-channel.tx -channelID energychannel