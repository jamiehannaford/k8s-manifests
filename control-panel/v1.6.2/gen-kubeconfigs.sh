#!/bin/bash

echo "Generate kubelet kubeconfigs"

kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=${HOSTNAME}.kubeconfig

kubectl config set-credentials system:node:${HOSTNAME} \
    --client-certificate=${HOSTNAME}.pem \
    --client-key=${HOSTNAME}-key.pem \
    --embed-certs=true \
    --kubeconfig=${HOSTNAME}.kubeconfig

kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:${HOSTNAME} \
    --kubeconfig=${HOSTNAME}.kubeconfig

kubectl config use-context default --kubeconfig=${HOSTNAME}.kubeconfig


echo "Generating kube-proxy"

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=ca.pem \
  --embed-certs=true \
  --server=https://127.0.0.1:6443 \
  --kubeconfig=kube-proxy.kubeconfig

kubectl config set-credentials kube-proxy \
  --client-certificate=kube-proxy.pem \
  --client-key=kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=kube-proxy.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=kube-proxy \
  --kubeconfig=kube-proxy.kubeconfig