#!/bin/bash

set -e

function print_info() {
    echo -e "\e[36mINFO: ${1}\e[m"
}

for package in ${EXTRA_PACKAGES}
do
    apk add --no-cache "${package}"
done

apk add py3-pip gcc musl-dev python3-dev pango zlib-dev jpeg-dev openjpeg-dev g++ libffi-dev
pip install mkdocs-with-pdf
pip install mkdocs-material
pip install qrcode

if [ -n "${REQUIREMENTS}" ] && [ -f "${GITHUB_WORKSPACE}/${REQUIREMENTS}" ]; then
    pip install -r "${GITHUB_WORKSPACE}/${REQUIREMENTS}"
else
    REQUIREMENTS="${GITHUB_WORKSPACE}/requirements.txt"
    if [ -f "${REQUIREMENTS}" ]; then
        pip install -r "${REQUIREMENTS}"
    fi
fi

if [ -n "${CONFIG_FILE}" ]; then
    print_info "Setting custom path for mkdocs config yml"
    export CONFIG_FILE="${GITHUB_WORKSPACE}/${CONFIG_FILE}"
else
    export CONFIG_FILE="${GITHUB_WORKSPACE}/mkdocs.yml"
fi

mkdocs build --config-file "${CONFIG_FILE}"
