$Dists = @(
    @{ dir = 'iqs-clients-deviceconfig-angular'; type = 'ng'; dist = 'config_devices' }
    # @{ dir = 'iqs-clients-emergencyconfig-angular'; type = 'ng'; dist = 'config_emergency' }
    # @{ dir = 'iqs-clients-eventconfig-angular'; type = 'ng'; dist = 'config_events' }
    # @{ dir = 'iqs-clients-incidents-angular'; type = 'ng'; dist = 'incidents' }
    # @{ dir = 'iqs-clients-manualcorrections-angular'; type = 'ng'; dist = 'manual_corrections' }
    # @{ dir = 'iqs-clients-monitoring-angular'; type = 'ng'; dist = 'monitoring' }
    # @{ dir = 'iqs-clients-objectconfig-angular'; type = 'ng'; dist = 'config_objects' }
    # @{ dir = 'iqs-clients-orgconfig-angular'; type = 'ng'; dist = 'config_organization' }
    # @{ dir = 'iqs-clients-retrospective-angular'; type = 'ng'; dist = 'retrospective' }
    # @{ dir = 'iqs-clients-routes-angular'; type = 'ng'; dist = 'dottraces' }
    # @{ dir = 'iqs-clients-schedule-angular'; type = 'ng'; dist = 'schedule' }
    # @{ dir = 'iqs-clients-statistics-angular'; type = 'ng'; dist = 'stats' }
    # @{ dir = 'iqs-clients-usersettings-angular'; type = 'ng'; dist = 'settings' }
    # @{ dir = 'iqs-clients-zoneconfig-angular'; type = 'ng'; dist = 'config_zones' }
    @{ dir = 'iqs-clients-home-angular'; type = 'ngx'; dist = 'home' }
    # @{ dir = 'iqs-clients-applications-angular'; type = 'ngx'; dist = 'applications' }
    # @{ dir = 'iqs-clients-dataprofiles-angular'; type = 'ngx'; dist = 'dataprofiles' }
    # @{ dir = 'iqs-clients-datamonitoring-angular'; type = 'ngx'; dist = 'datamonitoring' }
    # @{ dir = 'iqs-clients-guides-angular'; type = 'ngx'; dist = 'guides' }
    # @{ dir = 'iqs-clients-logging-angular'; type = 'ngx'; dist = 'logging' }
    # @{ dir = 'iqs-clients-msgtemplates-angular'; type = 'ngx'; dist = 'msg_templates' }
    # @{ dir = 'iqs-clients-users-angular'; type = 'ngx'; dist = 'users' }
)
$NgContainer = 'iqs-build-ng'
$NgxContainer = 'iqs-build-ngx'
$ClientsContainer = 'iquipsys-positron-clients'
$NgVersion = '1.0'
$NgxVersion = '1.0'
$ClientsVersion = '1.0'
$NgImage = "${NgContainer}:${NgVersion}"
$NgxImage = "${NgxContainer}:${NgxVersion}"
$ClientsImage = "${ClientsContainer}:${ClientsVersion}"