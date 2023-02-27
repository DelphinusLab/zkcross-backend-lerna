[ -d "./packages" ] || mkdir packages

cd packages
repo init -u git@github.com:DelphinusLab/zkcross-backend-lerna.git -b rio -m delphinus-backend.xml
repo sync
cd -

npm install
npx lerna bootstrap --hoist --nohoist=circomlib
