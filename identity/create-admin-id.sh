#!/bin/bash

# Default values
USERNAME="admin"
PASSWORD="pwd"
NAME="ca.localhost.com"
RUNSERVER=false

display_help() {
    echo "Usage: ./create-admin-id.sh -u <username> -p <password> -n <nameOfCA> "
    echo
    echo "   -u, --username    create admin user with specified username. Default is 'admin'"
    echo "   -p, --password    create admin user with specified password. Default is 'pwd'"
    echo "   -n, --name        create this CA with specified name. Default is ca.localhost.com"
    exit 1
}

while getopts ":u:p:n:h" opt; do
  case $opt in
    u)
      USERNAME=$OPTARG
      ;;
    p)
      PASSWORD=$OPTARG
      ;;
	n)
      NAME=$OPTARG
      ;;
	h)
      display_help
	  exit
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done


# Creating a new folder
mkdir -p fabric-ca

# FABRIC_CA_CLIENT_HOME
export FABRIC_CA_CLIENT_HOME=$PWD/fabric-ca/client  
# FABRIC_CA_SERVER_HOME
export FABRIC_CA_SERVER_HOME=$PWD/fabric-ca/server


#Initializing the CA Server
fabric-ca-server init -b $USERNAME:$PASSWORD -n $NAME

# Config Path -- Maybe Later
DEFAULT_CLIENT_CONFIG_YAML=$PWD/config/fabric-ca-server-config.yaml

# Set Path for Client
cp $DEFAULT_CLIENT_CONFIG_YAML  "$PWD/fabric-ca/server/"


