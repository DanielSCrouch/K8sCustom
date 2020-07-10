
# Set node IP and etcd node name 

INTERNAL_IP=10.0.0.4 # internal IP for instance
ETCD_NAME=$(hostname -s) 

# Download official etcd release binaries from GitHub 

echo something 

wget -q --show-progress --https-only --timestamping \
  'https://github.com/etcd-io/etcd/releases/download/v3.4.0/etcd-v3.4.0-linux-amd64.tar.gz'

echo "Downloaded etcd"

# Extract and install ectd server and etcdctl command line utility 

tar -xvf etcd-v3.4.0-linux-amd64.tar.gz
sudo mv etcd-v3.4.0-linux-amd64/etcd* /usr/local/bin/
 
# Configure the etcd server (run from home/dev/ or ~/) 

sudo mkdir -p /etc/etcd /var/lib/etcd
sudo cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/

# Create the etcd.service systemd unit file 

cat <<EOF | sudo tee /etc/systemd/system/etcd.service
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
Type=notify
ExecStart=/usr/local/bin/etcd \\
  --name ${ETCD_NAME} \\
  --cert-file=/etc/etcd/kubernetes.pem \\
  --key-file=/etc/etcd/kubernetes-key.pem \\
  --peer-cert-file=/etc/etcd/kubernetes.pem \\
  --peer-key-file=/etc/etcd/kubernetes-key.pem \\
  --trusted-ca-file=/etc/etcd/ca.pem \\
  --peer-trusted-ca-file=/etc/etcd/ca.pem \\
  --peer-client-cert-auth \\
  --client-cert-auth \\
  --initial-advertise-peer-urls https://${INTERNAL_IP}:2380 \\
  --listen-peer-urls https://${INTERNAL_IP}:2380 \\
  --listen-client-urls https://${INTERNAL_IP}:2379,https://127.0.0.1:2379 \\
  --advertise-client-urls https://${INTERNAL_IP}:2379 \\
  --initial-cluster-token etcd-cluster-0 \\
  --initial-cluster kubemaster1=https://10.0.0.3:2380,kubemaster2=https://10.0.0.4:2380 \\
  --initial-cluster-state new \\
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# Start the etcd server

echo "starting etcd server."
sudo systemctl daemon-reload
sudo systemctl enable etcd
sudo systemctl start etcd


