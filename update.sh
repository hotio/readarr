#!/bin/bash

branch=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/readarr/readarr/pulls?state=open&base=develop" | jq -r 'sort_by(.updated_at) | .[] | select((.head.repo.full_name == "Readarr/Readarr") and (.head.ref | contains("dependabot") | not)) | .head.ref' | tail -n 1)
version=$(curl -fsSL "https://readarr.servarr.com/v1/update/${branch}/changes?os=linux" | jq -r .[0].version)
[[ -z ${version} ]] && exit 1
[[ ${version} == "null" ]] && exit 0
sed -i "s/{READARR_VERSION=[^}]*}/{READARR_VERSION=${version}}/g" .github/workflows/build.yml
sed -i "s/{READARR_BRANCH=[^}]*}/{READARR_BRANCH=${branch}}/g" .github/workflows/build.yml
echo "##[set-output name=version;]${version}"
