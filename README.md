# Toil WES Helm chart

This is a toil-wes Helm chart to install the Toil WES support in an OpenShift Kubernetes cluster. This chart is an adaptation of the `docker-compose.yaml` provided in the official docs:

https://toil.readthedocs.io/en/latest/running/server/wes.html

## Quick deploy

* Install the [Helm](https://helm.sh/) client, and login into the cluster.

* Edit the file `values.yaml` in the `toil` directory. Set the correct URL to use.

* Run helm:

```sh
helm install quick toil
```

## TODO

* Make it compatible woth a standard Kubernetes installation. Write `Ingress` and `Deployment` objects. Allow storage class configuration.

* Allow more configuration directly by the chart.

