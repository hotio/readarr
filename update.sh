#!/bin/bash

if [[ ${1} == "checkdigests" ]]; then
    exit 0
elif [[ ${1} == "tests" ]]; then
    echo "List installed packages..."
    docker run --rm --entrypoint="" "${2}" apk -vv info | sort
    echo "Check if app works..."
    app_url="http://localhost:8787/system/status"
    docker run --network host -d --name service "${2}"
    currenttime=$(date +%s); maxtime=$((currenttime+60)); while (! curl -fsSL "${app_url}" > /dev/null) && [[ "$currenttime" -lt "$maxtime" ]]; do sleep 1; currenttime=$(date +%s); done
    curl -fsSL "${app_url}" > /dev/null
    status=$?
    echo "Show docker logs..."
    docker logs service
    exit ${status}
elif [[ ${1} == "screenshot" ]]; then
    app_url="http://localhost:8787/system/status"
    docker run --rm --network host -d --name service "${2}"
    currenttime=$(date +%s); maxtime=$((currenttime+60)); while (! curl -fsSL "${app_url}" > /dev/null) && [[ "$currenttime" -lt "$maxtime" ]]; do sleep 1; currenttime=$(date +%s); done
    docker run --rm --network host --entrypoint="" -u "$(id -u "$USER")" -v "${GITHUB_WORKSPACE}":/usr/src/app/src zenika/alpine-chrome:with-puppeteer node src/puppeteer.js
    exit 0
else
    branch=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/readarr/readarr/pulls?state=open&base=develop" | jq -r 'sort_by(.updated_at) | .[] | select((.head.repo.full_name == "Readarr/Readarr") and (.head.ref | contains("dependabot") | not)) | .head.ref' | tail -n 1)
    [[ -z ${branch} ]] && exit 0
    version=$(curl -fsSL "https://readarr.servarr.com/v1/update/${branch}/changes?os=linuxmusl&runtime=netcore&arch=x64" | jq -r .[0].version)
    [[ -z ${version} ]] && exit 1
    [[ ${version} == "null" ]] && exit 0
    echo '{"version":"'"${version}"'","branch":"'"${branch}"'"}' | jq . > VERSION.json
fi
