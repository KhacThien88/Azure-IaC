kubectl create namespace devops-tools
kubectl apply -f serviceAccount.yaml
kubectl create -f volume.yaml
kubectl apply -f deployment.yaml
kubectl apply -f services.yaml
sudo ufw allow 32000