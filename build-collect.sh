angularjs=(
    'iqs-libs-clientshell-angular'
    'iqs-clients-deviceconfig-angular'
    'iqs-clients-emergencyconfig-angular'
    'iqs-clients-eventconfig-angular'
    'iqs-clients-incidents-angular'
    'iqs-clients-manualcorrections-angular'
    'iqs-clients-monitoring-angular'
    'iqs-clients-objectconfig-angular'
    'iqs-clients-orgconfig-angular'
    'iqs-clients-retrospective-angular'
    'iqs-clients-routes-angular'
    'iqs-clients-schedule-angular'
    'iqs-clients-statistics-angular'
    'iqs-clients-usersettings-angular'
    'iqs-clients-zoneconfig-angular'
)

angular=(
    'iqs-clients-home-angular'
    'iqs-clients-dataprofiles-angular'
    'iqs-clients-datamonitoring-angular'
)

mkdir dist

for t in ${angularjs[@]}; do
    cd $t
    cp ./dist ../dist/$t
    cd ..
done

for t in ${angular[@]}; do
    cd $t
    cp ./dist/$t ../dist/$t
    cd ..
done

echo '<head><meta http-equiv="refresh" content="1;URL=/home/index.html" /></head>' >> ./dist/index.html