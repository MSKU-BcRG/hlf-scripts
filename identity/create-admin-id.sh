#!/bin/bash

# Default values
USERNAME="admin"
PASSWORD="pwd"
RUNSERVER=false
usage="ARTIK BURAYA NE YAZMAMIZ GEREKİYOR BİLMİYORUM HİÇ MANUAL YAZMADIM"


# Parameters that the script can take, and their consequences
while [ ! $# -eq 0 ]
do
	case "$1" in
		--username | -u)
			USERNAME=$1
			exit
			;;
        --password | -p)
        	PASSWORD=$1
        	exit
        ;;
		--help | -h)
			echo $usage
			exit
		;;
		*)
			echo $'Invalid option\n' $usage	
			exit
		;;		
	esac
	shift
done
# Creating a new folder
mkdir -p fabric-ca

# FABRIC_CA_CLIENT_HOME
export FABRIC_CA_CLIENT_HOME=$PWD/fabric-ca/client  
# FABRIC_CA_SERVER_HOME
export FABRIC_CA_SERVER_HOME=$PWD/fabric-ca/server


#Initializing the CA Server
fabric-ca-server init -b $USERNAME:$PASSWORD



