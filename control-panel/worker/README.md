## Set up

Ensure docker is set up. Then:

```bash
git clone https://github.com/jamiehannaford/k8s-manifests
cd control-panel/worker
./install-bins.sh
```

## Certs

```bash
mkdir -p /etc/kubernetes/tls
cp .../ca.pem /etc/kubernetes/tls
cp .../ca-key.pem /etc/kubernetes/tls
```

```bash
export HOSTNAME=worker-1
export MASTER_URL=1.2.3.4
./install-certs.sh
```

## Reconfigure CIDRs

SSH onto master, look for `--cluster-cidr` value in CM and proxy. Change kubelet/proxy systemd files.

## Systemd

```bash
cp systemd/* /etc/systemd/systemd
systemctl daemon-reload
systemctl start kubelet
systemctl start kube-proxy
```