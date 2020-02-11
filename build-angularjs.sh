dists=(
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

for t in ${dists[@]}; do
    cd $t
    gulp build
    cd ..
done