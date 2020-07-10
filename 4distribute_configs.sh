# worker 
workers=(kubeworker1 kubeworker2)
declare -A address=(
  [kubeworker1]=10.0.0.5
  [kubeworker2]=10.0.0.6
)

for instance in "${workers[@]}"; do
  echo "Updating $instance @ ${address[$instance]}" 
  scp ./configs/kube-proxy.kubeconfig "${address[$instance]}":~/
  scp ./configs/$instance.kubeconfig "${address[$instance]}":~/
done

# master 
masters=(kubemaster1 kubemaster2)
declare -A address=(
  [kubemaster1]=10.0.0.3
  [kubemaster2]=10.0.0.4
)
for instance in "${masters[@]}"; do
  echo "Updating $instance @ ${address[$instance]}" 
  scp ./configs/admin.kubeconfig "${address[$instance]}":~/
  scp ./configs/kube-controller-manager.kubeconfig "${address[$instance]}":~/
  scp ./configs/kube-scheduler.kubeconfig "${address[$instance]}":~/
  scp ./configs/encryption-config.yaml "${address[$instance]}":~/
done
