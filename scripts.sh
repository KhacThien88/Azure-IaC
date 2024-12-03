sudo apt update
sudo apt install -y git python3 python3-pip
cd ~
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
pip3 install -r requirements.txt
cp -r inventory/sample inventory/mycluster

