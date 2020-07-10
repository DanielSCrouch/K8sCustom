{

K8_PUBLIC_ADDRESS=10.0.0.1  # set to public IP (load balancer) 
K8_HOSTNAMES=kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local
NODES=10.0.0.1,10.0.0.3,10.0.0.4,10.0.0.5,10.0.0.6

cat > kubernetes-csr.json <<EOF
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "UK",
      "L": "London",
      "O": "Kubernetes",
      "OU": "K8s Custom"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${NODES},${K8_HOSTNAMES},${K8_PUBLIC_ADDRESS},127.0.0.1 \
  -profile=kubernetes \
  kubernetes-csr.json | cfssljson -bare kubernetes

}
