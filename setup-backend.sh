[ -d "./packages" ] || mkdir packages

cd packages
repo init -u git@github.com:zkcrossteam/zkcross-backend-lerna.git -b main -m delphinus-backend.xml
repo sync
cd -

npm install
npx lerna bootstrap --hoist --nohoist=circomlib
