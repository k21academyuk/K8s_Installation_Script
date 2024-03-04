To run the script follow the below steps:

Step 1: Download the file on your system(VM/OS)
Step 2: chmod +x <filename>	
Step 3: sh <filename>
Once done with the above 3 steps then run the below commands on the master:
  
kubeadm init
cp /etc/kubernetes/admin.conf $HOME/
chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
echo 'export KUBECONFIG=$HOME/admin.conf' >> $HOME/.bashrc
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
