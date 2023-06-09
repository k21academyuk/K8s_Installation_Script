#!/bin/bash

apt-get install -y curl openssh-server vim 
sed -e 's/^.*PermitRootLogin prohibit-password/PermitRootLogin yes/g' -i  /etc/ssh/sshd_config
systemctl restart sshd 
systemctl disable --now ufw

tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system

sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -m 0755 -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt install -y containerd.io

mkdir -p /etc/containerd
containerd config default>/etc/containerd/config.toml
sed -e 's/SystemdCgroup = false/SystemdCgroup = true/g' -i /etc/containerd/config.toml

systemctl daemon-reload
systemctl restart containerd
systemctl enable containerd

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B53DC80D13EDEF05

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

KUBE_VERSION=1.26.0
apt-get update

apt-get install -y kubelet=${KUBE_VERSION}-00  kubeadm=${KUBE_VERSION}-00 kubectl=${KUBE_VERSION}-00 kubernetes-cni 

apt-mark hold kubelet kubeadm kubectl
systemctl enable kubelet && systemctl start kubelet
