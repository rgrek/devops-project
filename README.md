# About the project
The goal of this project is to apply the knowledge I've gained through online courses by putting it into practice. I aim to build a CD pipeline implementing DevOps tools, such as Kubernetes, Helm, Terraform, Ansible, ArgoCD, Prometheus, Grafana and Elk stack. By doing this project, I intend to deepen my understanding of DevOps practices and various tools.

## About the example voting app that I will be using for the project
It is a microservice-based application running on Kubernetes. 

The application stack consists of:
- A front-end web app in Python which lets you vote between two options
- A Redis which collects new votes 
- A .NET worker which consumes votes and stores them in A Postgres database 
- A Node.js web app which shows the results of the voting in real time

---

# Getting started
**Prerequisites:**
1. [Helm](https://helm.sh/docs/intro/install/) CLI installed
2. [Minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download) Installed
3. Minikube Configured - run the following command below:
```
minikube addons enable ingress
```

## Running the app in Kubernetes
### Using k8s templates
The folder k8s-specifications contains the YAML specifications of the Voting App's services.

1. Create deployments and services
```
kubectl create -f k8s-specifications/
```
2. Run the following command to make the app accessible on `result.webapp.com` and `voting.webapp.com`
```
echo "$(minikube ip) result.webapp.com voting.webapp.com" >> /etc/hosts
```
The voting application is then accessible on `voting.webapp.com` and result application on `result.webapp.com`.

To **remove** it run:
```
kubectl delete -f k8s-specifications/
```
---
### Using Helm chart
1. Add and update a repository where the helm chart is stored
```
helm repo add gitrepo https://rgrek.github.io/devops-project/helm-chart
helm repo update
```
2. Install by running:
``` 
helm install voting-app gitrepo/voting-app
```
3. Run the following command to make the app accessible on `result.webapp.com` and `voting.webapp.com`
```
echo "$(minikube ip) result.webapp.com voting.webapp.com" >> /etc/hosts
```

> If you would like to verify the Helm Chart's Integrity and Provenance refer to [Verification Guide](helm-chart/README.md)

The voting application is then accessible on `voting.webapp.com` and result application on `result.webapp.com`.

To **remove** it run:
```
helm uninstall voting-app
```
