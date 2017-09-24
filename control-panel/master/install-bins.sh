#!/bin/bash

echo "Installing cfssl"
docker run --rm -v /usr/local/bin:/go/bin golang go get -u github.com/cloudflare/cfssl/cmd/cfssl
docker run --rm -v /usr/local/bin:/go/bin golang go get -u github.com/cloudflare/cfssl/cmd/cfssljson

echo "Installing k8s bins"
wget https://dl.k8s.io/v1.6.2/kubernetes-server-linux-amd64.tar.gz
tar xvf kubernetes-server-linux-amd64.tar.gz
cd kubernetes/server/bin
cp kube-apiserver kube-controller-manager kube-scheduler kubelet kube-proxy kubectl /usr/bin

echo "Installing CNI bins"
wget https://github.com/containernetworking/plugins/releases/download/v0.6.0/cni-plugins-amd64-v0.6.0.tgz
tar -xvf cni-plugins-amd64-v0.6.0.tgz -C /opt/cni/bin/