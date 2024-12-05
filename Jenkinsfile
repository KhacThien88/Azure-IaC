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
   stage('Setup Terraform') {
            steps {
                script {
                    writeFile file: 'provider.tf', text: "${env.PROVIDER_TF}"
                }
            }
        }
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
        sh 'echo Unit Test'
      }
    }
    stage('Create Resource Terraform in Azure'){
      steps{
        withCredentials([azureServicePrincipal('IaC-Azure-Resource')]) {
          sh 'terraform init'
          sh 'terraform plan -out main.tfplan'
          sh 'terraform apply main.tfplan'
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
    
//     stage('Install Tools') {
//     steps {
//         script {
//             remote.user = 'root'
//             remote.password = '111111aA'
//         }
//         sshCommand(remote: remote, command: """
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
//         """)
//     }
// }


// stage('Create resource Azure Terraform') {
//     steps {
//         script {
//             remote.user = 'root'
//             remote.password = '111111aA'
//         }
//         sshCommand remote: remote, command: 'whoami'

//     }
// }
    
//     stage('Install script in VM'){
//       steps{
//         script{
//           def vm_1_ip = sh(script: "terraform output -raw public_ip_vm_1", returnStdout: true).trim()
//           def vm_2_ip = sh(script: "terraform output -raw public_ip_vm_2", returnStdout: true).trim()
//           sshagent(['ssh-agent']) {
//                         sh """
//                         ssh -o StrictHostKeyChecking=no adminuser@${vm_ip} << EOF
//                         if [ ! -d ~/kubespray ]; then
//                               echo "Cloning kubespray repository..."
//                               sudo apt update
//                               sudo apt install -y git python3 python3-pip
//                               cd ~
//                               git clone https://github.com/kubernetes-sigs/kubespray.git
//                               cd kubespray
//                               pip3 install -r requirements.txt
//                               cp -r inventory/sample inventory/mycluster
//                         else
//                               echo "Kubespray directory already exists, skipping installation."
//                         fi
//                         EOF
//                         """
//                     }
//         }
//       }
//     }
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

