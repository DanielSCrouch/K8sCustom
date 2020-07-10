
./auth_scripts/certificate_authority.sh
./auth_scripts/admin_client.sh 
./auth_scripts/controller_manager_client.sh 
./auth_scripts/kubelet_client.sh 
./auth_scripts/kube_proxy_client.sh 
./auth_scripts/kubernetes_api_server.sh
./auth_scripts/scheduler_client.sh 
./auth_scripts/service_account_key_pair.sh 

rm admin-csr.json
rm ca-config.json
rm kube-controller-manager-csr.json
rm ca-csr.json
rm kube-proxy-csr.json
rm kubernetes-csr.json
rm kube-scheduler-csr.json
rm kubeworker1-csr.json
rm kubeworker2-csr.json
rm service-account-csr.json

rm admin.csr
rm ca.csr
rm kube-controller-manager.csr
rm kube-proxy.csr
rm kubernetes.csr
rm kube-scheduler.csr
rm kubeworker1.csr
rm kubeworker2.csr
rm service-account.csr

mv admin-key.pem certs
mv admin.pem certs
mv ca-key.pem certs
mv ca.pem certs
mv kube-controller-manager-key.pem certs
mv kube-controller-manager.pem certs
mv kube-proxy-key.pem certs
mv kube-proxy.pem certs
mv kubernetes-key.pem certs
mv kubernetes.pem certs
mv kube-scheduler-key.pem certs
mv kube-scheduler.pem certs
mv kubeworker1-key.pem certs
mv kubeworker1.pem certs
mv kubeworker2-key.pem certs
mv kubeworker2.pem certs
mv service-account-key.pem certs
mv service-account.pem certs


