

workers=(kubeworker1 kubeworker2)
declare -A address=(
  [kubeworker1]=10.0.0.5
  [kubeworker2]=10.0.0.6
)


for instance in "${workers[@]}"; do

echo "Updating $instance @ ${address[$instance]}"

cat > ${instance}-csr.json <<EOF
{
  "CN": "system:node:${instance}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "UK",
      "L": "London",
      "O": "system:nodes",
      "OU": "K8s Custom"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${instance},${address[$instance]} \
  -profile=kubernetes \
  ${instance}-csr.json | cfssljson -bare ${instance}

done
