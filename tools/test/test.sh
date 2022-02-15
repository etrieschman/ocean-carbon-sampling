#!/bin/bash
set -x -e

SCRIPT_DIR=$(dirname $0)
pushd ${SCRIPT_DIR}/../..
mkdir -p ${SCRIPT_DIR}/../../tmp
pytest -s --cov --cov-report=html --cov-report=xml --cov-report=term  ${1: }