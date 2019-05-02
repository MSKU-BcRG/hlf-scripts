#!/bin/bash



if [ $1 = "stop" ]; then
    killall fabric-ca-server  2> /dev/null
	echo 'Fabric CA Server Has Been STOPPED'
	exit 0
fi

if [ $1 = "clear" ]; then
	read -p "Are you sure, all identities will be deleted? " -n 1 -r
	echo  ""
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		rm -rf $PWD/fabric-ca
		echo 'Fabric CA Server Components All Deleted'
	fi
	exit 0
fi


# Default values
NETWORK="ca.localhost.com"
PORT="7054"
BACKGROUND=false
usage="ARTIK BURAYA NE YAZMAMIZ GEREKİYOR BİLMİYORUM HİÇ MANUAL YAZMADIM"

while [ ! $# -eq 0 ]
do
	case "$1" in
		--network | -n)
			NETWORK=$1
			exit
			;;
		--port | -p)
			PORT=$1
			exit
			;;
		--background | -b)
			BACKGROUND=true
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


echo 'Launching network with '$NETWORK

# Set the location 
export FABRIC_CA_SERVER_HOME=$PWD/fabric-ca/server

# Launch network
fabric-ca-server -n $NETWORK -p $PORT start &

