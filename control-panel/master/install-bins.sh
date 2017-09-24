#!/bin/bash

git clone https://github.com/jamiehannaford/k8s-manifests

wget https://dl.k8s.io/v1.6.2/kubernetes-server-linux-amd64.tar.gz
tar xvf kubernetes-server-linux-amd64.tar.gz
cd kubernetes/server/bin
cp kube-apiserver kube-controller-manager kube-scheduler kubelet kube-proxy kubectl /usr/bin
