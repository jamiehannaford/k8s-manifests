## Set up

Ensure docker is set up. Then:

```bash
git clone https://github.com/jamiehannaford/k8s-manifests
cd k8s-manifests/control-panel/worker
```

## Certs

```bash
mkdir -p /etc/kubernetes/tls
cp .../* /etc/kubernetes/tls
```

## Save kubeconfig

```bash
cp kubelet.kubeconfig /etc/kubernetes
```

## Systemd

```bash
cp kubelet.service /etc/systemd/systemd
systemctl daemon-reload
systemctl start kubelet
```