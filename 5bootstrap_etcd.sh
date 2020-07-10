
# master 
masters=(kubemaster1 kubemaster2)
declare -A address=(
  [kubemaster1]=10.0.0.3
  [kubemaster2]=10.0.0.4
)
for instance in "${masters[@]}"; do
  echo "Updating $instance @ ${address[$instance]}" 
  scp ./setup_scripts/bootstrap_ectd_on_master.sh "${address[$instance]}":~/
  
done
