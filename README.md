# hlf-scripts
Scripts for creation hyperledger fabric network components.

## Identity
### create-admin-id-sh
Initializes the CA server with an admin identity.
!!! This CA server is not configured for TLS connections. Don't use for production.

## Installing

### prereqs-ubuntu.sh
For installing Prerequisites for Hyperledger Fabric and Hyperledger Fabric CA use prereqs-ubuntu.sh.
Unfortunately this is not enough. Please install GoLang manualy and don't forget to set the environment variable GOPATH to point at the Go workspace.

### fabric-ca-install.sh
This file will install Hyperledger Fabric CA to your Go workspace. Then commands will be available system wide.