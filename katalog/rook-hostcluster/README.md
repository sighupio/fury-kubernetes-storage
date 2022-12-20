# Rook Host Cluster

<!-- <KFD-DOCS> -->

Rook Host Cluster deploys a Ceph [host storage cluster](https://rook.io/docs/rook/v1.10/CRDs/Cluster/host-cluster/) using Rook CRs as defined by [Rook Operator](../rook-operator).

The reference architecture implemented by this module is one with a dedicated node pool with directly attached storage provisioned by a human operator, as summarised in the following diagram:
![Fury Storage Reference Architecture](../../docs/assets/reference-architecture.png)

> ⚠️ **WARNING**
> Most probably, you don't want to use this package *as-is* but you want to choose in which nodes the Ceph cluster will be deployed. Head over to the [example](../../examples/rook-hostcluster-nodeSelector/) that shows how to do that.

## Requirements

- Kubernetes >= `1.19.0`
- Kustomize = `v3.5.3`
- [rook-operator](../rook-operator)
- [prometheus-operator](https://github.com/sighupio/fury-kubernetes-monitoring/tree/main/katalog/prometheus-operator)
- Empty raw disks attached to Ceph nodes

## Image repository and tag

* Ceph image: `registry.sighup.io/fury/ceph/ceph:v17.2.`

## Configuration

This package deploys Ceph with the following configuration:

- 2 MGRs
- 3 MONs and OSDs
- RBD pool with replication enabled
- CephFS filesystem with replication enabled and hot standby on metadata pool

## Deployment

You can deploy Rook Host Cluster by running the following command:

```shell
kustomize build | kubectl apply -f -
```

### Accessing Ceph dashboard

You can access the Ceph dashboard with your browser by port-forwarding on port 8443:

```shell
kubectl port-forward svc/rook-ceph-mgr-dashboard 8443:8443 --namespace rook-ceph
```

You can retrieve the generated credentials for the `admin` user running the follwing:

```shell
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo
```

Now if you go to <https://127.0.0.1:8443> on your browser you can authenticate and interact with your Ceph cluster.

> ⚠️ **WARNING**
> Be careful since, by default, the dashboard gives you R/W access to your Ceph cluster and you risk of deleting resources created throught the operator CRDs.

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
