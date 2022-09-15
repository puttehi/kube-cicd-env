SHELL:=/usr/bin/bash

start: deps
	minikube start
	minikube kubectl -- get po -A

deps:
	minikube version

dashboard:
	minikube dashboard

hello-world:
	@echo "run: source use-minictl.sh"
	@echo "run: make start"
	@echo "run in another terminal: minikube dashboard --url"
	@echo "run: minikube kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4"
	@echo "run: minikube kubectl expose deployment hello-minikube --type=NodePort --port=8080"
	@echo "run: kubectl port-forward service/hello-minikube 7080:8080"
	@echo "go to: localhost:7080"
