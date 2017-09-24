## Install deps:

```bash
git clone https://github.com/jamiehannaford/k8s-manifests
cd control-panel/master
./install-bins.sh
```

## Download binaries:

```bash
./install-bins.sh
```

## Set envs

```bash
# kubelet hostname 
export HOSTNAME=master

# external IP for kube-apiserver TLS
export KUBERNETES_PUBLIC_ADDRESS=localhost
```

## Install certs

```bash
./install-certs.sh
```

## Generate kubeconfigs

```bash
./gen-kubeconfigs.sh
```

## Move etcd certs

```bash
cp ... /etc/kubernetes/tls
```

## Edit systemd files

- etcd server in kube-apiserver 
- etcd TLS cert paths
- ensure kubelet does not need `--hostname-override` (needs to match $HOSTNAME)
- ensure kubelet kubeconfig is set to /etc/kubernetes/tls/$HOSTNAME.kubeconfig

## Move systemd files 

```bash
cp systemd/* /etc/systemd/system
```

## Enable

```bash
systemctl daemon-reload
systemctl start kube-apiserver
systemctl start kube-scheduler
systemctl start kube-controller-manager
systemctl start kube-proxy
systemctl start kubelet
```

## install CNI

export kubever=$(kubectl version | base64 | tr -d '\n')
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"