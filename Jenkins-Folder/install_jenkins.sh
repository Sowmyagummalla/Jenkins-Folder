#!/bin/bash
#Jenkins Installation
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y fontconfig openjdk-17-jre
sudo apt-get install -y jenkins
sed -i 's/HTTP_PORT=8080/HTTP_PORT=30500/' /etc/default/jenkins
sed -i 's/JENKINS_PORT=8080/JENKINS_PORT=30500/' /lib/systemd/system/jenkins.service #Environment="JENKINS_PORT=30500"
sudo systemctl daemon-reload
sudo systemctl restart jenkins

#Nginx Installation
sudo apt-get install -y nginx

#Trivy Installation
sudo apt-get install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install -y trivy
