# `rook-operator` Package Maintenance

To prepare a new release of this package:

1. Get the current upstream release

```bash
export ROOK_RELEASE=v1.10.13
wget -c https://raw.githubusercontent.com/rook/rook/${ROOK_RELEASE}/deploy/examples/common.yaml \
  https://raw.githubusercontent.com/rook/rook/${ROOK_RELEASE}/deploy/examples/crds.yaml \
  https://raw.githubusercontent.com/rook/rook/${ROOK_RELEASE}/deploy/examples/toolbox.yaml \
  https://raw.githubusercontent.com/rook/rook/${ROOK_RELEASE}/deploy/examples/operator.yaml

cat common.yaml | kubernetes-split-yaml -
cat operator.yaml | kubernetes-split-yaml -
mv toolbox.yaml rook-ceph-tools-deploy.yml
```

  Replace `ROOK_RELEASE` with the current upstream release.

2. Check the differences introduced by pulling the upstream release and any new file in `kustomization.yaml`

3. Sync the new image to our registry in the [`storage` images.yaml file fury-distribution-container-image-sync repository](https://github.com/sighupio/fury-distribution-container-image-sync/blob/main/modules/storage/images.yml).

4. Update the `kustomization.yaml` file with the new image.
