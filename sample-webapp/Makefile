SHELL:=/usr/bin/bash

LOCAL_IP=$(echo $(minikube ip))

publish: build
	docker push puttehi/react-docker

build: docker-login-local
	npm run package

deploy-local: create-ns-local docker-login-local kustomize
	minikube kubectl -- apply -f compiled.yaml
	minikube kubectl -- get deployment
	echo "Running on: $(LOCAL_IP):31000"

destroy-local:
	-minikube kubectl -- delete -f compiled.yaml

create-ns-local:
	-minikube kubectl -- create namespace react-docker

docker-login-local:
	eval $(minikube -p minikube docker-env) && minikube docker-env && docker login

kustomize:
	minikube kubectl -- kustomize > compiled.yaml
