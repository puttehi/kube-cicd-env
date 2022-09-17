SHELL:=/usr/bin/bash

start: deps
	minikube start
	minikube kubectl -- get po -A

deps:
	minikube version

dashboard:
	minikube dashboard --url

argocd-install:
	-minikube kubectl -- create namespace argocd
	minikube kubectl -- apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	@echo "Initial admin secret if available (delete it!):"
	-minikube kubectl -- -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
	@echo "For first login:"
	@echo "1. in another terminal: make argocd-connect"	
	@echo "2. login with CLI: argocd login localhost:8080"
	@echo "3. update pwd: argocd account update-password"
	@echo "4. TODO: delete secret: -minikube kubectl -- -n argocd delete secret argocd-initial-admin-secret"

argocd-connect:
	minikube kubectl -- port-forward svc/argocd-server -n argocd 8080:443

deploy-webapp:
	make -C ./sample-webapp/ deploy-local

destroy-webapp:
	make -C ./sample-webapp/ destroy-local

hello-world:
	@echo "run: source use-minictl.sh"
	@echo "run: make start"
	@echo "run in another terminal: minikube dashboard --url"
	@echo "run: minikube kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4"
	@echo "run: minikube kubectl expose deployment hello-minikube --type=NodePort --port=8080"
	@echo "run: kubectl port-forward service/hello-minikube 7080:8080"
	@echo "go to: localhost:7080"
