# nfs subdir external provisioner

This example shows how to customize the NFS Subdir External Provisioner with the right NFS server and path

1. Download dependencies with `furyctl vendor`
2. Add a patch like the following one into `kustomization.yaml`
    ```yaml
    patchesJson6902:
    - target:
      kind: Deployment
      version: v1
      group: apps
      name: nfs-subdir-external-provisioner
      patch: |
        - op: replace
          path: /spec/template/spec/containers/0/env/1/value
          value: server.nfs.example
        - op: replace
          path: /spec/template/spec/volumes/0/nfs/server
          value: server.nfs.example
        - op: replace
          path: /spec/template/spec/containers/0/env/2/value
          value: /exports
        - op: replace
          path: /spec/template/spec/volumes/0/nfs/path
          value: /exports
        - op: add
          path: /spec/template/spec/nodeSelects
          value:
            node.kubernetes.io/role: infra
        - op: add
          path: /spec/template/spec/tolerations
          value:
            - effect: NoSchedule
              key: node.kubernetes.io/role
              operator: Equal
              value: infra
    ```
3. Deploy everything using `kustomize build . | kubectl apply -f - --server-side`
