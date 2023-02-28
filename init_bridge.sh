set -e

if [ ! -f initbridge.lock ];
then
    cp packages/zkp/circom/verifier.sol packages/solidity/contracts/ZKPVerifier.sol
    sed -i "s/\^0.6.11/^0.8.0/" packages/solidity/contracts/ZKPVerifier.sol

    node packages/monitors/src/tools/init_BlockHeight.js
        
    cd packages/solidity
    npx truffle migrate --f 2 --to 2 --network goerli
    npx truffle migrate --f 2 --to 2 --network bsctestnet
    npx truffle migrate --f 2 --to 2 --network cantotestnet
    cd -

    cd packages/solidity/clients/
    node config-contracts-info.js
    cd -

    cd packages/solidity/clients/tools/bridge
    node init.js goerli
    node init.js bsctestnet
    node init.js cantotestnet
    cd -

    touch initbridge.lock
fi

echo "please start monitors"
