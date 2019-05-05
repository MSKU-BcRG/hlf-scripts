# hlf-scripts
Scripts for creation hyperledger fabric network components.

## Identity
### create-admin-id-sh
Initializes the CA server with an admin identity.
!!! This CA server is not configured for TLS connections. Don't use for production.

Usage: ./create-admin-id.sh -u <username> -p <password> -n <nameOfCA> "
    -u, --username    create admin user with specified username. Default is 'admin'
    -p, --password    create admin user with specified password. Default is 'pwd'
    -n, --name        create this CA with specified name. Default is 'ca.localhost.com'

## Installing

### prereqs-ubuntu.sh
For installing Prerequisites for Hyperledger Fabric and Hyperledger Fabric CA use prereqs-ubuntu.sh
Unfortunately this is not enough. Please install GoLang manualy and don't forget to set the environment variable GOPATH to point at the Go workspace.

### fabric-ca-install.sh
This file will install Hyperledger Fabric CA to your Go workspace. Then commands will be available system wide.