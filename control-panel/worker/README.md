## Set up

Ensure docker is set up. Then:

```bash
docker run --rm -v /usr/local/bin:/go/bin golang go get -u github.com/cloudflare/cfssl/cmd/cfssl
docker run --rm -v /usr/local/bin:/go/bin golang go get -u github.com/cloudflare/cfssl/cmd/cfssljson
./install-bins.sh
```

## Certs

```bash
mkdir -p /etc/kubernetes/tls
cp .../ca.pem /etc/kubernetes/tls
cp .../ca-key.pem /etc/kubernetes/tls
```

```
export HOSTNAME=worker-1
export MASTER_URL=1.2.3.4
./create-creds.sh
```

## Systemd

```bash
cp kubelet.service /etc/systemd/systemd
systemctl daemon-reload
systemctl start kubelet
```