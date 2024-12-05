def remote=[:]
remote.name = 'vkt'
remote.host = '192.168.23.138'
remote.allowAnyHosts = true

def vm1=[:]
vm1.name = 'vm1'
vm1.allowAnyHosts = true

def vm2=[:]
vm2.name = 'vm2'
vm2.allowAnyHosts = true

pipeline {
  environment {
    PROVIDER_TF = credentials('provider-azure')
    dockerimagename = "ktei8htop15122004/savingaccountfe"
    dockerImage = ""
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
  }

//   agent {
//     kubernetes {
//       yaml '''
//       apiVersion: v1
//       kind: Pod
//       spec:
//         serviceAccountName: jenkins-admin
//         dnsConfig:
//           nameservers:
//             - 8.8.8.8
//         containers:
//         - name: docker
//           image: docker:latest
//           imagePullSecrets:
//             - name: regcred
//           command:
//             - cat
//           tty: true
//           securityContext:
//             privileged: true
//           volumeMounts:
//             - mountPath: /var/run/docker.sock
//               name: docker-sock
//         - name: kubectl
//           image: bitnami/kubectl:latest
//           imagePullSecrets:
//             - name: regcred
//           command:
//             - cat
//           securityContext:
//             runAsUser: 0
//           tty: true
//         volumes:
//           - name: docker-sock
//             hostPath:
//               path: /var/run/docker.sock
//       '''
//     }
//   }
  agent any 
  stages {
//    stage('Setup Terraform') {
//             steps {
//                 script {
//                     writeFile file: 'provider.tf', text: "${env.PROVIDER_TF}"
//                 }
//             }
//         }
    stage('Check Agent') {
            steps {
                script {
                    echo "Running on agent: ${env.NODE_NAME}"
                }
            }
        }
//     stage('Install Terraform') {
//     steps {
//         script {
//             sh '''
//             if ! command -v terraform &> /dev/null
//             then
//                 echo "Terraform not found, installing..."
//                 sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
//                 wget -O- https://apt.releases.hashicorp.com/gpg | \
//                 gpg --dearmor | \
//                 sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
//                 gpg --no-default-keyring \
//                 --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
//                 --fingerprint
//                 echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
//                 https://apt.releases.hashicorp.com \$(lsb_release -cs) main" | \
//                 sudo tee /etc/apt/sources.list.d/hashicorp.list
//                 sudo apt update
//                 sudo apt-get install terraform
//             else
//                 echo "Terraform is already installed"
//             fi
//             '''
//         }
//     }
// }
    stage('Unit Test') {
      when {
        expression {
          return env.BRANCH_NAME != 'master';
        }
      }
      steps {
        sh 'terraform --version'
        // sh 'terraform validate'

      }
    }
    stage('Create Resource Terraform in Azure'){
      steps{
        withCredentials([azureServicePrincipal(credentialsId:'IaC-Azure-Resource', subscriptionIdVariable: 'SUBS_ID',clientIdVariable: 'CLIENT_ID', clientSecretVariable: 'CLIENT_SECRET', tenantIdVariable: 'TENANT_ID')
]) {
          sh 'terraform init'
          sh "terraform plan -var=client_id=${CLIENT_ID} -var=client_secret=${CLIENT_SECRET} -var=subscription_id=${SUBS_ID} -var=tenant_id=${TENANT_ID} -out main.tfplan"
          sh "terraform apply -var=client_id=${CLIENT_ID} -var=client_secret=${CLIENT_SECRET} -var=subscription_id=${SUBS_ID} -var=tenant_id=${TENANT_ID} main.tfplan"
        }
      }
    }
     stage('Test Outputs') {
            steps {
                script {
                    def publicIpVm1 = sh(script: 'terraform output -raw public_ip_vm_1', returnStdout: true).trim()
                    def publicIpVm2 = sh(script: 'terraform output -raw public_ip_vm_2', returnStdout: true).trim()

                    echo "Public IP of VM 1: ${publicIpVm1}"
                    echo "Public IP of VM 2: ${publicIpVm2}"
                }
            }
        }
   

    // stage('Build image') {
    //   steps {
    //     container('docker') {
    //       script {
    //         sh 'docker pull node:latest'
    //         sh 'docker pull nginx:stable-alpine'
    //         sh 'docker build --network=host -t ktei8htop15122004/savingaccountfe .'
    //       }
    //     }
    //   }
    // }

    // stage('Pushing Image') {
    //   steps {
    //     container('docker') {
    //       script {
    //         sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
    //         sh 'docker tag ktei8htop15122004/savingaccountfe ktei8htop15122004/savingaccountfe'
    //         sh 'docker push ktei8htop15122004/savingaccountfe:latest'
    //       }
    //     }
    //   }
    // }
    
    stage('Install kubespray') {
    steps {
        script {
            vm1.user = 'root'
            vm1.password = '111111aA@'
            vm1.host = sh(script: "terraform output -raw public_ip_vm_1", returnStdout: true).trim()
            vm2.host = sh(script: "terraform output -raw public_ip_vm_2", returnStdout: true).trim()
        }
        sshCommand(remote: vm1, command: """
                        if [ ! -d ~/kubespray ]; then
                              echo "Cloning kubespray repository..."
                              sudo apt update
                              sudo apt install -y git python3 python3-pip
                              git clone https://github.com/kubernetes-sigs/kubespray.git 
                              pip3 install -r ~/kubespray/requirements.txt
                              pip3 install --upgrade cryptography
                              cp -r ~/kubespray/inventory/sample  ~/kubespray/inventory/mycluster             
                              echo "
# This inventory describe a HA typology with stacked etcd (== same nodes as control plane)
# and 3 worker nodes
# See https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html
# for tips on building your # inventory

# Configure 'ip' variable to bind kubernetes services on a different ip than the default iface
# We should set etcd_member_name for etcd cluster. The node that are not etcd members do not need to set the value,
# or can set the empty string value.
[kube_control_plane]
node1 ansible_host=${vm1.host}  ansible_user=adminuser ansible_ssh_pass=111111aA@ ip=10.0.1.4 etcd_member_name=etcd1
# node2 ansible_host=52.237.213.222  ansible_user=adminuser ansible_ssh_pass=111111aA@ ip=10.0.1.5 etcd_member_name=etcd2>
# node3 ansible_host=95.54.0.14  # ip=10.3.0.3 etcd_member_name=etcd3

[etcd:children]
kube_control_plane

[kube_node]
node2 ansible_host=${vm2.host}  ansible_user=adminuser ansible_ssh_pass=111111aA@ ip=10.0.1.5
# node4 ansible_host=95.54.0.15  # ip=10.3.0.4
# node5 ansible_host=95.54.0.16  # ip=10.3.0.5
# node6 ansible_host=95.54.0.17  # ip=10.3.0.6
                              " > ~/kubespray/inventory/mycluster/inventory.ini

                        else
                              cp -r  ~/kubespray/inventory/sample  ~/kubespray/inventory/mycluster
                              pip3 install -r ~/kubespray/requirements.txt
                              pip3 install --upgrade cryptography
                              echo "
# This inventory describe a HA typology with stacked etcd (== same nodes as control plane)
# and 3 worker nodes
# See https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html
# for tips on building your # inventory

# Configure 'ip' variable to bind kubernetes services on a different ip than the default iface
# We should set etcd_member_name for etcd cluster. The node that are not etcd members do not need to set the value,
# or can set the empty string value.
[kube_control_plane]
node1 ansible_host=${vm1.host}  ansible_user=adminuser ansible_ssh_pass=111111aA@ ip=10.0.1.5 etcd_member_name=etcd1
# node2 ansible_host=52.237.213.222  ansible_user=adminuser ansible_ssh_pass=111111aA@ ip=10.0.1.5 etcd_member_name=etcd2>
# node3 ansible_host=95.54.0.14  # ip=10.3.0.3 etcd_member_name=etcd3

[etcd:children]
kube_control_plane

[kube_node]
node2 ansible_host=${vm2.host}  ansible_user=adminuser ansible_ssh_pass=111111aA@ ip=10.0.1.4
# node4 ansible_host=95.54.0.15  # ip=10.3.0.4
# node5 ansible_host=95.54.0.16  # ip=10.3.0.5
# node6 ansible_host=95.54.0.17  # ip=10.3.0.6
                              " > ~/kubespray/inventory/mycluster/inventory.ini
                              echo "Kubespray directory already exists, skipping installation."
                        fi
        """)
    }
}

stage('Install Ansible and playbook') {
    steps {
        script {
            vm1.user = 'root'
            vm1.password = '111111aA@'
            vm1.host = sh(script: "terraform output -raw public_ip_vm_1", returnStdout: true).trim()
            vm2.host = sh(script: "terraform output -raw public_ip_vm_2", returnStdout: true).trim()
        }
        sshCommand(remote: vm1, command: """
                set -e  # Exit on any error
                echo 'Updating package lists...'
                sudo apt update -y || { echo 'apt update failed!'; exit 1; }

                echo 'Installing software-properties-common...'
                sudo apt install -y software-properties-common || { echo 'apt install failed!'; exit 1; }

                echo 'Adding Ansible PPA...'
                sudo add-apt-repository ppa:ansible/ansible -y || { echo 'add-apt-repository failed!'; exit 1; }

                echo 'Updating package lists again...'
                sudo apt update -y || { echo 'Second apt update failed!'; exit 1; }

                echo 'Installing Ansible...'
                sudo apt install -y ansible || { echo 'apt install ansible failed!'; exit 1; }

                echo 'Checking Ansible version...'
                ansible --version || { echo 'ansible --version failed!'; exit 1; }
            """)
        
    }
}
stage('Playing book Ansible...'){
  steps{
    echo 'Running kubespray playbook...'
    sshpass -V
    ansiblePlaybook credentialsId: 'ssh-credentials', inventory: '~/kubespray/inventory/mycluster/inventory.ini', become: true,becomeUser: 'root',playbook:'~/kubespray/cluster.yml'
  }
}  
    // stage('Install script in VM'){
    //   steps{
    //     script{
    //       def vm_1_ip = sh(script: "terraform output -raw public_ip_vm_1", returnStdout: true).trim()
    //       def vm_2_ip = sh(script: "terraform output -raw public_ip_vm_2", returnStdout: true).trim()
    //       sshagent(['ssh-agent']) {
    //                     sh """
    //                     ssh -o StrictHostKeyChecking=no adminuser@${vm_ip} << EOF
    //                     if [ ! -d ~/kubespray ]; then
    //                           echo "Cloning kubespray repository..."
    //                           sudo apt update
    //                           sudo apt install -y git python3 python3-pip
    //                           cd ~
    //                           git clone https://github.com/kubernetes-sigs/kubespray.git
    //                           cd kubespray
    //                           pip3 install -r requirements.txt
    //                           cp -r inventory/sample inventory/mycluster
    //                     else
    //                           echo "Kubespray directory already exists, skipping installation."
    //                     fi
    //                     EOF
    //                     """
    //                 }
    //     }
    //   }
    // }
//     stage('Create Deployment YAML') {
//     steps {
//         writeFile file: '/home/jenkins/agent/workspace/Pipeline-SavingAccountFE_main/deployment-react.yaml', text: '''apiVersion: apps/v1
// kind: Deployment
// metadata:
//   name: react-app-deployment
//   labels:
//     app: react-app
// spec:
//   replicas: 1
//   selector:
//     matchLabels:
//       app: react-app
//   template:
//     metadata:
//       labels:
//         app: react-app
//     spec:
//       containers:
//       - name: savingaccountfe
//         image: ktei8htop15122004/savingaccountfe:latest
//         ports:
//         - containerPort: 81
//         resources:
//           requests:
//             memory: "128Mi"
//             cpu: "250m"
//           limits:
//             memory: "512Mi"
//             cpu: "500m"'''
//     }
// }

//     stage('Create Service YAML') {
//     steps {
//         writeFile file: '/home/jenkins/agent/workspace/Pipeline-SavingAccountFE_main/service-react.yaml', text: '''apiVersion: v1
// kind: Service
// metadata:
//   name: react-app-svc
// spec:
//   type: NodePort
//   selector:
//     app: react-app
//   ports:
//     - name: http
//       port: 80
//       targetPort: 80
//       nodePort: 32100'''
//     }
// }

//     stage('Deploying App to Kubernetes') {
//       steps {
//         container('kubectl') {
//           withCredentials([file(credentialsId: 'kube-config-admin', variable: 'TMPKUBECONFIG')]) {
//             sh "cat \$TMPKUBECONFIG"
//             sh "cp \$TMPKUBECONFIG ~/.kube/config"
//             sh "ls -l \$TMPKUBECONFIG"
//             sh "pwd"
//             sh "kubectl apply -f deployment-react.yaml"
//             sh "kubectl apply -f service-react.yaml"
//           }
//         }
//       }
//     }
}
}

