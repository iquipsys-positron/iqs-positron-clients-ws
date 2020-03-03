#!/usr/bin/env pwsh

$global:Angularjs = @(
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

$global:Angular = @(
    'iqs-clients-home-angular'
    'iqs-clients-dataprofiles-angular'
    'iqs-clients-datamonitoring-angular'
)

$global:dist = @{
    'config_devices' = 'iqs-clients-deviceconfig-angular/dist'
    'config_emergency' = 'iqs-clients-emergencyconfig-angular/dist'
    'config_events' = 'iqs-clients-eventconfig-angular/dist'
    'incidents' = 'iqs-clients-incidents-angular/dist'
    'manual_corrections' = 'iqs-clients-manualcorrections-angular/dist'
    'monitoring' = 'iqs-clients-monitoring-angular/dist'
    'config_objects' = 'iqs-clients-objectconfig-angular/dist'
    'config_organization' = 'iqs-clients-orgconfig-angular/dist'
    'retrospective' = 'iqs-clients-retrospective-angular/dist'
    'dottraces' = 'iqs-clients-routes-angular/dist'
    'schedule' = 'iqs-clients-schedule-angular/dist'
    'stats' = 'iqs-clients-statistics-angular/dist'
    'settings' = 'iqs-clients-usersettings-angular/dist'
    'config_zones' = 'iqs-clients-zoneconfig-angular/dist'
    'home' = 'iqs-clients-home-angular/dist/iqs-clients-home-angular'
    'dataprofiles' = 'iqs-clients-dataprofiles-angular/dist/iqs-clients-dataprofiles-angular'
    'datamonitoring' = 'iqs-clients-datamonitoring-angular/dist/iqs-clients-datamonitoring-angular'
}