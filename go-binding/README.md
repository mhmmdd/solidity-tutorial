# Go Native Binding for Solidity 

[Source](https://geth.ethereum.org/docs/developers/dapp-developer/native-bindings)

### Compile a Solidity file to generate the **ABI**
````shell
$ vagrant up && vagrant ssh
$ cd /vagrant/go-binding

# Compile the solidity file and generate the ABI
$ solc --abi Storage.sol -o build
# Compiler run successful. Artifact(s) can be found in directory "build".

# Download go-ethereum
$ git clone https://github.com/ethereum/go-ethereum.git
$ cd go-ethereum
$ go build ./cmd/abigen
$ cd ..
$ cp go-ethereum/abigen .
#$ rm -rf go-ethereum
$ ./abigen --abi ./build/Storage.abi --pkg main --type Storage --out Storage.go
````

### Deploy the contract
````shell
$ solc --bin Storage.sol -o build
# Compiler run successful. Artifact(s) can be found in directory "build".

$ abigen --abi build/Storage.abi --pkg main --type Storage --out Storage.go --bin build/Storage.bin
$ go run deploy.go
````
