1️⃣ Install Vault Using Helm

Add repo:

helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update


Create namespace:

kubectl create namespace vault


Install Vault (dev mode for lab):

helm install vault hashicorp/vault \
  --namespace vault \
  --set "server.dev.enabled=true"


Verify:

kubectl get pods -n vault


Expected:

vault-0   Running

2️⃣ Access Vault UI
kubectl port-forward vault-0 -n vault 8200:8200


Open:

👉 http://localhost:8200

Login Token:

root

3️⃣ Enable Kubernetes Auth

Enter Vault pod:

kubectl exec -it vault-0 -n vault -- sh


Enable auth:

vault auth enable kubernetes

4️⃣ Configure Kubernetes Auth
vault write auth/kubernetes/config \
  kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443"

5️⃣ Enable KV Secrets Engine
vault secrets enable -path=kv kv-v2

6️⃣ Create Sample Secret
vault kv put kv/web-app db_password=supersecure123

7️⃣ Create Vault Policy
vault policy write web-policy - <<EOF
path "kv/data/web-app" {
  capabilities = ["read"]
}
EOF

8️⃣ Create Kubernetes Auth Role
vault write auth/kubernetes/role/web-role \
  bound_service_account_names=default \
  bound_service_account_namespaces=dev \
  policies=web-policy \
  ttl=24h

🔐 Vault → Kubernetes Secret Flow

You now have:

Pod → Kubernetes Auth → Vault → Dynamic Secret


🔥 This is enterprise security architecture.