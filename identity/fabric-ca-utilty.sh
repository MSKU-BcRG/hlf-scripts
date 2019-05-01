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

if [ $1 = "enroll" ]; then
	# Default values for enrollment
	ADMIN="admin"
	PASSPORT="pwd"
	PORT="7054"
	HOST="localhost"
	while [ ! $# -eq 0 ]
		do
			case "$1" in
				--admin | -a)
					ADMIN=$1
					exit
					;;
				--passport | -p)
					PASSPORT=$1
					exit
					;;
				--host | -h)
				HOST=$1
				exit
				;;
				--port)
					PORT = "7054"
					exit
					;;
				esac
				shift
			done

	export FABRIC_CA_CLIENT_HOME=$PWD/fabric-ca/client/fabric-ca/$ADMIN
	fabric-ca-client enroll -u http://$ADMIN:$PASSPORT@$HOST:$PORT
	exit 0
fi

# Default values
NETWORK="ca.localhost.com"
PORT="7054"

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

	esac
	shift
done


echo 'Launching network with '$NETWORK

# Set the location 
export FABRIC_CA_SERVER_HOME=$PWD/fabric-ca/server

# Launch network
fabric-ca-server -n $NETWORK -p $PORT start &

