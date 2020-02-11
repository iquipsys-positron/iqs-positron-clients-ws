dists=(
    'iqs-clients-home-angular'
    'iqs-clients-dataprofiles-angular'
    'iqs-clients-datamonitoring-angular'
)

for t in ${dists[@]}; do
    cd $t
    npm i
    npm run build:prod
    cd ..
done