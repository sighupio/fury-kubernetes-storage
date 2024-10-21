# `nfs-subdir-external-provisioner` Package Maintenance

To prepare a new release of this package:

> 20241024: latest `nfs-subdir-external-provisioner` helm chart version is `4.0.18`
1. Generate manifests from latest `nfs-subdir-external-provisioner` helm chart: `bash MAINTENANCE.sh`
2. Check the differences introduced by pulling the upstream release and any new file in `kustomization.yaml`
3. Sync the new image to our registry in the [`storage` images.yaml file fury-distribution-container-image-sync repository](https://github.com/sighupio/fury-distribution-container-image-sync/blob/main/modules/storage/images.yml).
4. Update the `kustomization.yaml` file with the new image.
