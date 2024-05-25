<!DOCTYPE html>
<html lang="en">

<body>

<h1>Kubernetes Installation Instructions</h1>

<h2>1. Clone the Repository</h2>
<pre>git clone https://github.com/k21academyuk/K8s_Installation_Script.git</pre>
<pre>cd K8s_Installation_Script</pre>
<h2>2. Make cluster.sh Executable</h2>
<pre>chmod 777 cluster.sh</pre>

<h2>3. Run the Script</h2>
<pre>sh cluster.sh</pre>

<p>Once you run the script in <b>all nodes</b>, execute the following commands:</p>

<h2>4. Initializing the Control-Plane Node</h2>
<p>Run the following command on the <strong>master node</strong>:</p>
<pre>kubeadm init </pre>
<p>Note: Copy the kubeadm join command & paste it on worker nodes.</p>

<h2>5. Set Environment Variable on the Master Node</h2>
<p>To start using the cluster, set the environment variable on the <strong>master node</strong>:</p>
<pre>
export KUBECONFIG=/etc/kubernetes/admin.conf
echo 'export KUBECONFIG=/etc/kubernetes/admin.conf' >> .bashrc
</pre>

<h2>6. Install CNI</h2>
<p>Install Container Network Interface (CNI) so that pods can communicate across nodes and also Cluster DNS to start functioning. Apply Weavnet CNI on the <strong>master node</strong>:</p>
<pre>kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml</pre>

<h2>7. Node Status</h2>
<p>Verify the staus of master & worker nodes<strong>(master node)</strong>:</p>
<pre>
kubectl get nodes
</pre>

<h2>8. Verify System Pods </h2>
<p>Verify the kube-system pods(coreDNS, ETCD, kubelet, etc ..)<strong>(master node)</strong>:</p>
<pre>kubectl get pods -n kube-system</pre>

</body>
</html>
</body>
</html>
