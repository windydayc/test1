#!/bin/bash

## configure kube-controller-manager
## https://openyurt.io/docs/installation/openyurt-prepare/#1-kube-controller-manager-adjustment

sed -i 's/--controllers=.*$/--controllers=-nodelifecycle,*,bootstrapsigner,tokencleaner/g' /etc/kubernetes/manifests/kube-controller-manager.yaml