#!/bin/bash

# START ALL OVER AGAIN, NOW EVERYTHING IS CLEAN :)
eksctl create cluster --name my-cluster --region eu-west-1 --node-type t2.micro --nodegroup-name alpine-nodes --nodes 2
kubectl cluster-info # check, still works, config file okay, due to same region, same profile, same clustername
kubectl apply -f service-account.yaml # create SA my-service-account
kubectl apply -f role.yaml # create Role pod-reader
kubectl apply -f role-binding.yaml # create RB object, bind together the SA and ROLE
kubectl apply -f pod-alpine.yaml # create alpine image container, declared the SA of this Pod
kubectl exec -it pods/alpine -- sh # connect to the Pod, running shell
    # operations with alpine package keeper (pack.manager of alpine)
    apk update
    apk upgrade
    apk add curl # download/install curl
    ## download kubernetes latest version
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl # install kubectl, otherwise wont work, /bin/sh wont find it
    kubectl cp /$PWD/service-nginx.yaml default/alpine:/service-manifest.yaml # copy manifest file from local to the alpine POD on default ns, default/ can be omitted
    kubectl apply -f service-manifest.yaml # WORKS
        'Error from server (Forbidden): error when retrieving current configuration of:
        Resource: "/v1, Resource=services", GroupVersionKind: "/v1, Kind=Service"
        Name: "nginx-service", Namespace: "default"
        from server for: "service-manifest.yaml": services "nginx-service" is forbidden: User "system:serviceaccount:default:my-service-account" cannot get resource "services" in API group "" in the namespace "default"'
    kubectl run test-pod --image alpine
        'Error from server (Forbidden): pods is forbidden: User "system:serviceaccount:default:my-service-account" cannot create resource "pods" in API group "" in the namespace "default"'
    # added "create" verb to Role:{rules:{verbs[ENABLED OPERATIONS]}}
    kubectl run test-pod --image alpine
        'pod/test-pod created'
    kubectl run test-pod --image alpine --namespace other-ns
        'Error from server (Forbidden): pods is forbidden: User "system:serviceaccount:default:my-service-account" cannot create resource "pods" in API group "" in the namespace "other-ns"'
        # The Pod is not created, because that would need a Cluster Role instead of a regular one
