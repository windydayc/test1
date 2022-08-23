#!/bin/bash

## configure kube-apiserver
## https://openyurt.io/zh/docs/installation/openyurt-prepare/#3-kube-apiserver%E8%B0%83%E6%95%B4

sed -i '/dnsPolicy:/d' /etc/kubernetes/manifests/kube-apiserver.yaml
sed -i '/spec:/a \ \ dnsPolicy: "None"' /etc/kubernetes/manifests/kube-apiserver.yaml

yurt_tunnel_dns_clusterip=`kubectl get svc yurt-tunnel-dns -n kube-system -o jsonpath='{.spec.clusterIP}'`
sed -i '/spec:/a \
  dnsConfig:\
    nameservers:\
    \- '${yurt_tunnel_dns_clusterip}'\
    searches:\
    \- kube-system.svc.cluster.local\
    \- svc.cluster.local\
    \- cluster.local\
    options:\
    \- name: ndots\
      value: "5"' /etc/kubernetes/manifests/kube-apiserver.yaml

sed -i 's/--kubelet-preferred-address-types=.*$/--kubelet-preferred-address-types=Hostname,InternalIP,ExternalIP/g' /etc/kubernetes/manifests/kube-apiserver.yaml