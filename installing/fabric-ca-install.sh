#!/bin/bash


echo 'Fabric CA Client & Server Installing...'
go get -u github.com/hyperledger/fabric-ca/cmd/...
echo 'Fabric CA Client & Server Installed'
fabric-ca-server version
fabric-ca-client version
