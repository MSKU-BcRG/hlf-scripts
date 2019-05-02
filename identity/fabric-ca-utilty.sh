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

# GUNCELLENECEK
if [ $1 = "enroll" ]; then
	# Default values for enrollment
	ADMIN="admin"
	PASSPORT="pwd"
	PORT="7054"
	HOST="localhost"
	shift 1
	while (( "$#" )); do
		echo $1
		case "$1" in
			--port)
			PORT=$2
			shift 2
			;;
			-a|--admin)
			ADMIN=$2
			shift 2
			;;
			-p|--passport)
			PASSPORT=$2
			shift 2
			;;
			-h|--host)
			HOST=$2
			shift 2
			;;
			-*|--*=) # unsupported flags
			echo "Error: Unsupported flag $1" >&2
			exit 1
			;;
  		esac
	done

	# Config Path -- Maybe Later
	DEFAULT_CLIENT_CONFIG_YAML=$PWD/config/fabric-ca-client-config.yaml

	# Set Path for Client
	export FABRIC_CA_CLIENT_HOME=$PWD/fabric-ca/client/caserver/$ADMIN
	mkdir -p $FABRIC_CA_CLIENT_HOME
	cp $DEFAULT_CLIENT_CONFIG_YAML  "$FABRIC_CA_CLIENT_HOME/"

	fabric-ca-client enroll -u http://$ADMIN:$PASSPORT@$HOST:$PORT
	echo "For Checking Identity"
	fabric-ca-client identity list
	exit 0
fi

if [ $1 = "generate" ]; then
	# Default values for enrollment
	REGISTERADMIN="admin"
	USERNAME="sample"
	PASSPORT="pwd"
	PEERTYPE="orderer"
	HOST="localhost"
	PORT="7054"
	shift 1
	while (( "$#" )); do
		echo $1
		case "$1" in
			--port)
			PORT=$2
			shift 2
			;;
			-a|--admin)
			REGISTERADMIN=$2
			shift 2
			;;
			-p|--passport)
			PASSPORT=$2
			shift 2
			;;
			-u|--username)
			USERNAME=$2
			shift 2
			;;
			-t|--peertype)
			PEERTYPE=$2
			shift 2
			;;
			-h|--host)
			HOST=$2
			shift 2
			;;
			-*|--*=) # unsupported flags
			echo "Error: Unsupported flag $1" >&2
			exit 1
			;;
  		esac
	done


	echo "Generating process is starting"
	export FABRIC_CA_CLIENT_HOME=$PWD/fabric-ca/client/caserver/$REGISTERADMIN

	if [ $PEERTYPE = "peer" ];
	then
	    echo "Registering: "$USERNAME" as peer"
    	ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true"'
    	fabric-ca-client register --id.type client --id.name $USERNAME"-admin" --id.secret $PASSPORT --id.affiliation $USERNAME --id.attrs $ATTRIBUTES
   	fi

	if [ $PEERTYPE = "orderer" ];
	then
		echo "Registering: "$USERNAME" as orderer"
    	ATTRIBUTES='"hf.Registrar.Roles=orderer,user,client"'
 		fabric-ca-client register --id.type client --id.name $USERNAME"-admin" --id.secret $PASSPORT --id.affiliation $USERNAME --id.attrs $ATTRIBUTES
	fi

	echo "Enrolling: "$USERNAME"-admin"

	export FABRIC_CA_CLIENT_HOME=$PWD/fabric-ca/client/$USERNAME/admin
    # Enroll the admin identity
    fabric-ca-client enroll -u http://$USERNAME-admin:$PASSPORT@$HOST:$PORT

	# Setup the MSP for acme
    mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts
    echo "====> $FABRIC_CA_CLIENT_HOME/msp/admincerts"
    cp $FABRIC_CA_CLIENT_HOME/../../caserver/admin/msp/signcerts/*  $FABRIC_CA_CLIENT_HOME/msp/admincerts

	exit 0
fi

# Default values
NETWORK="ca.localhost.com"
PORT="7054"

while (( "$#" )); do
  case "$1" in
    -p|--port)
      PORT=$2
      shift 2
      ;;
    -n|--network)
      NETWORK=$2
      shift 2
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done


echo 'Launching network with '$NETWORK

# Set the location
export FABRIC_CA_SERVER_HOME=$PWD/fabric-ca/server

# Launch network
fabric-ca-server -n $NETWORK -p $PORT start &

