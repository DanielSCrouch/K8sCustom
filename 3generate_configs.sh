
./config_scripts/admin_config.sh
./config_scripts/kube_controller_manager_config.sh
./config_scripts/kubelet_config.sh
./config_scripts/kube_proxy_config.sh
./config_scripts/kube_scheduler_config.sh 
./config_scripts/data_encryption_config.sh

mv admin.kubeconfig configs
mv kube-controller-manager.kubeconfig configs
mv kube-proxy.kubeconfig configs
mv kube-scheduler.kubeconfig configs
mv kubeworker1.kubeconfig configs
mv kubeworker2.kubeconfig configs
mv encryption-config.yaml configs
