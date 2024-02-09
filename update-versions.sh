#!/bin/bash
branch=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/readarr/readarr/pulls?state=open&base=develop" | jq -re 'sort_by(.updated_at) | .[] | select((.head.repo.full_name == "Readarr/Readarr") and (.head.ref | contains("dependabot") | not)) | .head.ref') || exit 1
branch=$(tail -n 1 <<< "${branch}")
version=$(curl -fsSL "https://readarr.servarr.com/v1/update/${branch}/changes?os=linuxmusl&runtime=netcore&arch=x64" | jq -re '.[0].version') || exit 1
curl -fsSL "https://readarr.servarr.com/v1/update/${branch}/updatefile?version=${version}&os=linuxmusl&runtime=netcore&arch=x64" -o /dev/null || exit 1
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg branch "${branch}" \
    '.version = $version | .branch = $branch' <<< "${json}" | tee VERSION.json
