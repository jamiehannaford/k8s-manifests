## Install deps:

```bash
apt-get update && apt-get install -y docker.io
docker run --rm -v /usr/local/bin:/go/bin go get -u github.com/cloudflare/cfssl/cmd/cfssl
docker run --rm -v /usr/local/bin:/go/bin go get -u github.com/cloudflare/cfssl/cmd/cfssljson
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

## Download binaries:

```bash
wget https://dl.k8s.io/v1.6.2/kubernetes-server-linux-amd64.tar.gz
tar xvf kubernetes-server-linux-amd64.tar.gz
cd kubernetes/server/bin
cp kube-apiserver kube-controller-manager kube-scheduler kubelet kube-proxy kubectl /usr/bin
```

## Edit systemd files

- etcd server in kube-apiserver 

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