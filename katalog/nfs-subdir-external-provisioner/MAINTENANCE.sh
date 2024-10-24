#!/bin/bash
# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

[ ! "$(which yq)" ] && echo "yq missing. it is required" && exit 1
[ ! "$(which curl)" ] && echo "curl missing. it is required" && exit 1
[ ! "$(which docker)" ] && echo "docker missing. it is required" && exit 1

helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner --force-update
latest_helm_chart_version=$(curl -s https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/index.yaml | yq -e '.entries.nfs-subdir-external-provisioner | .[].version' | sort -rn | head -1)
helm template --release-name nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --namespace nfs-subdir-external-provisioner --version "${latest_helm_chart_version}" > deploy.yaml

mkdir -p resources

# Create an array of kinds present in the input file
kinds=$(yq -N e '.kind' "deploy.yaml" | sort --uniq)

# Loop over each kind and create a separate file
# shellcheck disable=SC2068
for kind in ${kinds[@]}; do
  output_file="resources/$(echo "${kind}" | tr '[:upper:]' '[:lower:]').yaml"
  yq e "select(.kind == \"$kind\")" "deploy.yaml" > "$output_file"
done

rm deploy.yaml

# shellcheck disable=SC2046
docker run --rm -v $(pwd)/resources:/tmp/resources -w /tmp/resources docker.io/library/golang:1.20 bash -c 'go install github.com/google/addlicense@v1.1.1 && addlicense -c "SIGHUP s.r.l" -v -l bsd -y "2017-present" .'
