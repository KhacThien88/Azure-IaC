sudo apt update
sudo apt install -y git python3 python3-pip
cd ~
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
pip3 install -r requirements.txt
cp -r inventory/sample inventory/mycluster
ansible-playbook -i inventory/mycluster/inventory.ini --become --become-user=root cluster.yml
kubectl create namespace devops-tools
kubectl apply -f serviceAccount.yaml
kubectl create -f volume.yaml
kubectl apply -f deployment.yaml
kubectl apply -f services.yaml
sudo ufw allow 32000