KUBERNETES_PUBLIC_ADDRESS=10.0.0.1 # set to cluster public IP

for instance in kubeworker1 kubeworker2; do
  kubectl config set-cluster k8s_cluster \
    --certificate-authority=./certs/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=${instance}.kubeconfig

  kubectl config set-credentials system:node:${instance} \
    --client-certificate=./certs/${instance}.pem \
    --client-key=./certs/${instance}-key.pem \
    --embed-certs=true \
    --kubeconfig=${instance}.kubeconfig

  kubectl config set-context default \
    --cluster=k8s_cluster \
    --user=system:node:${instance} \
    --kubeconfig=${instance}.kubeconfig

  kubectl config use-context default --kubeconfig=${instance}.kubeconfig
done
