# Rook Operator NodeSelector

This example shows how to customize your Rook deployment changing the node selector and the tolerations applied to the operator itself and to the CSI provisioners.

0. Download dependencies with `furyctl vendor`
1. In `rook-operator-nodeSelector.yaml`, modify the `nodeSelector` and `tolerations` fields to match your needs.
2. Deploy everything using `kustomize build . | kubectl apply -f - --server-side`
