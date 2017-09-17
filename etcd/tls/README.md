```
#get a shell in a golang container
docker run -ti --rm -v /tmp:/out golang /bin/bash 

#build etcd-ca and copy it back out
git clone https://github.com/coreos/etcd-ca
cd etcd-ca
./build
cp /go/etcd-ca/bin/etcd-ca /out
exit

#now we have etcd-ca in /tmp ready to copy wherever we need it
cp /tmp/etcd-ca /usr/bin/
```

```
etcd-ca init --passphrase ''
```

```
etcd-ca new-cert --passphrase '' --ip $ETCD_IP1 --domain $ETCD_HOSTNAME1 server1
etcd-ca sign --passphrase '' server1
etcd-ca export --insecure --passphrase '' server1 | tar xvf -
etcd-ca chain server1 > server1.ca.crt

etcd-ca new-cert --passphrase '' --ip $ETCD_IP2 --domain $ETCD_HOSTNAME2 server2
etcd-ca sign --passphrase '' server2
etcd-ca export --insecure --passphrase '' server2 | tar xvf -
etcd-ca chain server2 > server2.ca.crt

etcd-ca new-cert --passphrase '' --ip $ETCD_IP3 --domain $ETCD_HOSTNAME3 server3
etcd-ca sign --passphrase '' server3
etcd-ca export --insecure --passphrase '' server3 | tar xvf -
etcd-ca chain server3 > server3.ca.crt
```

```
etcd-ca new-cert  --passphrase '' client
etcd-ca sign  --passphrase '' client
etcd-ca export --insecure  --passphrase '' client | tar xvf -
```

Then download etcd and etcdctl
