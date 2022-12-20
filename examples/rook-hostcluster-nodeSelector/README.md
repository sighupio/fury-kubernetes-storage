# Rook Operator NodeSelector

This example shows how to customize the Ceph cluster deployment through the CRDs provided by the Rook operator changing the node selector, tolerations and device filters.

0. Download dependencies with `furyctl vendor`
1. In `rook-hostCluster-nodeSelector.yaml`, modify the `placement` and `deviceFilter` fields to match your needs.
2. Deploy everything using `kustomize build . | kubectl apply -f - --server-side`
