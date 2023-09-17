rm -rf ./assets/meta
mkdir -p ./assets/meta
mkdir -p ./.tmp

cd .tmp && git clone https://github.com/tyrcord/tbase.git

cp tbase/country/country.json ../assets/meta

cd .. && rm -rf .tmp
