#!/bin/bash

set -eo pipefail

[[ -z "${USE_DEBUG}" ]] || set -x

GRAFANA_DATA_DIR=$( cd $( dirname ${BASH_SOURCE[0]} ) && pwd )

kubectl create configmap grafana-dashboards --from-file="${GRAFANA_DATA_DIR}/dashboards" -o json --dry-run | \
    kubectl apply --namespace rackspace-system -f -

for manifest in $GRAFANA_DATA_DIR/*.yaml; do
    sigil -p -f "$manifest" | kubectl apply -f -
done
