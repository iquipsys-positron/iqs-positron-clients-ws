#!/bin/bash

if [[ $IQS_SERVER_URL ]]; then
    js_configs=()
    while IFS=  read -r -d $'\0'; do
        js_configs+=("$REPLY")
    done < <(find . -name config.js -print0)
    for i in "${js_configs[@]}"; do
        sed -ri "s/([\"']+serverUrl[\"']+:\s*[\"'])([^\"']*)([\"'])/\1$(echo $IQS_SERVER_URL | sed -e 's/[\/&]/\\&/g')\3/g" $i
    done
    json_configs=()
    while IFS=  read -r -d $'\0'; do
        json_configs+=("$REPLY")
    done < <(find . -name config.json -print0)
    for i in "${json_configs[@]}"; do
        tmp=$(mktemp)
        jq ".session.serverUrl = \"${IQS_SERVER_URL}\"" $i > "$tmp" && mv "$tmp" $i
        chmod 755 $i
    done
fi