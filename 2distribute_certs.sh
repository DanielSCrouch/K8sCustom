# worker 
workers=(kubeworker1 kubeworker2)
declare -A address=(
  [kubeworker1]=10.0.0.5
  [kubeworker2]=10.0.0.6
)

for instance in "${workers[@]}"; do
  echo "Updating $instance @ ${address[$instance]}" 
  scp ./certs/ca.pem "${address[$instance]}":~/
  scp ./certs/$instance-key.pem "${address[$instance]}":~/
  scp ./certs/$instance.pem "${address[$instance]}":~/
done

# master
masters=(kubemaster1 kubemaster2)
declare -A address=(
  [kubemaster1]=10.0.0.3
  [kubemaster2]=10.0.0.4
) 
for instance in "${masters[@]}"; do
  echo "Updating $instance @ ${address[$instance]}"
  scp ./certs/ca.pem "${address[$instance]}":~/
  scp ./certs/ca-key.pem "${address[$instance]}":~/
  scp ./certs/kubernetes-key.pem "${address[$instance]}":~/
  scp ./certs/kubernetes.pem "${address[$instance]}":~/
  scp ./certs/service-account-key.pem "${address[$instance]}":~/
  scp ./certs/service-account.pem "${address[$instance]}":~/
done
