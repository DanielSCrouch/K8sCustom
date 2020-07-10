KUBERNETES_PUBLIC_ADDRESS=10.0.0.1 # set to cluster public IP

{
  kubectl config set-cluster k8s_cluster \
    --certificate-authority=./certs/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=admin.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=./certs/admin.pem \
    --client-key=./certs/admin-key.pem \
    --embed-certs=true \
    --kubeconfig=admin.kubeconfig

  kubectl config set-context default \
    --cluster=k8s_cluster \
    --user=admin \
    --kubeconfig=admin.kubeconfig

  kubectl config use-context default --kubeconfig=admin.kubeconfig
}
