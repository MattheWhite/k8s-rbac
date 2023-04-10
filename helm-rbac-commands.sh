#!/bin/bash

# Add drupaldocker image helm chart
helm repo add azure-marketplace https://marketplace.azurecr.io/helm/v1/repo

helm install my-release azure-marketplace/drupal
'NAME: my-release
LAST DEPLOYED: Wed Mar  8 22:08:36 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: drupal
CHART VERSION: 12.5.10
APP VERSION: 9.4.8** Please be patient while the chart is being deployed **'

kubectl get serviceaccounts  OR kubectl get sa
'NAME                 SECRETS   AGE
default              0         45m
my-release-drupal    0         19m
my-release-mariadb   0         19m'
  
kubectl get pods my-release-drupal-66c4865864-c9tbz -o yaml > ~/Desktop/pod.yaml
  
# Create a role named "pod-reader" that allows user to perform "get", "watch" and "list" on pods
kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods
'role.rbac.authorization.k8s.io/pod-reader created'

    OR

Use manifest file !




# START ALL OVER
## Create a Cluster in AWS EKS
eksctl create cluster --name my-cluster --region eu-west-1 --node-type t2.micro --nodegroup-name alpine-nodes --nodes 2


# Create a new Service Account, can be done with this command, or use a manifest file, or use command
kubectl create serviceaccount my-service-account

    OR

kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-service-account
  namespace: default
EOF
'serviceaccount/my-service-account created'


# Create K8s resource (Pod) via manifest file
kubectl apply -f pod-alpine.yaml
'pod/alpine created'

# check if the recreation succeeded and the container still alive
kubectl get all

# enter into the container with execute an sh terminal session
## su root works
kubectl exec pods/alpine --tty -i -- sh

# check
kubectl get services --as my-service-accoount
'Error from server (Forbidden): services is forbidden: User "my-service-accoount" cannot list resource "services"
in API group "" in the namespace "default"'

# NOT GOOD, just for educative purposes
kubectl create rolebinding my-service-account \
  --clusterrole=view \
  --serviceaccount=default:my-service-account \
  --namespace=default
'rolebinding.rbac.authorization.k8s.io/my-service-account created'

# Check
kubectl get all --as my-service-account
Error from server (Forbidden): pods is forbidden: User "my-service-account" cannot list resource "pods" in API group "" in the namespace "default"
Error from server (Forbidden): replicationcontrollers is forbidden: User "my-service-account" cannot list resource "replicationcontrollers" in API group "" in the namespace "default"
Error from server (Forbidden): services is forbidden: User "my-service-account" cannot list resource "services" in API group "" in the namespace "default"
Error from server (Forbidden): daemonsets.apps is forbidden: User "my-service-account" cannot list resource "daemonsets" in API group "apps" in the namespace "default"
Error from server (Forbidden): deployments.apps is forbidden: User "my-service-account" cannot list resource "deployments" in API group "apps" in the namespace "default"
Error from server (Forbidden): replicasets.apps is forbidden: User "my-service-account" cannot list resource "replicasets" in API group "apps" in the namespace "default"
Error from server (Forbidden): statefulsets.apps is forbidden: User "my-service-account" cannot list resource "statefulsets" in API group "apps" in the namespace "default"
Error from server (Forbidden): horizontalpodautoscalers.autoscaling is forbidden: User "my-service-account" cannot list resource "horizontalpodautoscalers" in API group "autoscaling" in the namespace "default"
Error from server (Forbidden): cronjobs.batch is forbidden: User "my-service-account" cannot list resource "cronjobs" in API group "batch" in the namespace "default"
Error from server (Forbidden): jobs.batch is forbidden: User "my-service-account" cannot list resource "jobs" in API group "batch" in the namespace "default"

kubernetes-rbac-general-MattheWhite % kubectl delete rolebindings.rbac.authorization.k8s.io my-service-account
'rolebinding.rbac.authorization.k8s.io "my-service-account" deleted'

# Check
kubectl describe pods alpine

# Describe detailed information about service accounts
kubectl describe sa # ALL
kubectl describe sa <SERVICE_ACC_NAME>

# check existing roles in default namespace
kubectl get roles.rbac.authorization.k8s.io
'NAME            CREATED AT
eks:az-poller   2023-03-09T09:14:14Z'

# Create new role for only pods
kubectl apply -f role.yaml
'role.rbac.authorization.k8s.io/pod-reader created'

kubectl get roles.rbac.authorization.k8s.io
'NAME            CREATED AT
eks:az-poller   2023-03-09T09:14:14Z
pod-reader      2023-03-09T10:42:56Z'

kubectl get roles.rbac.authorization.k8s.io pod-reader -o yaml
'apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"rbac.authorization.k8s.io/v1","kind":"Role","metadata":{"annotations":{},"name":"pod-reader","namespace":"default"},"rules":[{"apiGroups":[""],"resources":["pods"],"verbs":["get","watch","list"]}]}
  creationTimestamp: "2023-03-09T10:42:56Z"
  name: pod-reader
  namespace: default
  resourceVersion: "14855"
  uid: ...
rules:
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - watch
  - list'
  ### GOOD

###OR USE THIS BUT ALWAYS RECOMMENDED TO USE MANIFEST FILES
kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods
'role.rbac.authorization.k8s.io/pod-reader created'

# Create role binding (Object, everything is an Object/Component in k8s)
# check
kubectl get rolebindings.rbac.authorization.k8s.io
'NAME            ROLE                 AGE
eks:az-poller   Role/eks:az-poller   97m'

kubectl apply -f role-binding.yml
'rolebinding.rbac.authorization.k8s.io/read-pods created'

kubectl get rolebindings.rbac.authorization.k8s.io
'NAME            ROLE                 AGE
eks:az-poller   Role/eks:az-poller   97m
read-pods       Role/pod-reader      5s'

# check pods
kubectl get pods
'NAME     READY   STATUS    RESTARTS   AGE
alpine   1/1     Running   0          109m'

# connect to the container (Pod)
kubectl exec alpine -it -- sh

# Create an NGINX Service
kubectl apply -f service-nginx.yaml
'service/nginx-service created'

#---->>  IT SHOULDNT WORK BECAUSE THE SERVICEACCOUNT NOT SUPPOSED TO ALLOW SERVICE CREATION'
kubectl get svc
'NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
kubernetes      ClusterIP   10.100.0.1     <none>        443/TCP   3h8m
nginx-service   ClusterIP   10.100.99.63   <none>        80/TCP    9s'

kubectl delete svc nginx-service
'service "nginx-service" deleted'

kubectl expose -f service-nginx.yaml
'service/nginx-service exposed'

kubectl get svc
'NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
kubernetes      ClusterIP   10.100.0.1      <none>        443/TCP   3h13m
nginx-service   ClusterIP   10.100.66.161   <none>        80/TCP    9s'


eksctl get nodegroup alpine-nodes --cluster my-cluster
'CLUSTER		NODEGROUP	STATUS	CREATED		        MIN SIZE  MAX SIZE	DESIRED CAPACITY	INSTANCE TYPE	IMAGE ID	ASG NAME						                        TYPE
my-cluster	alpine-nodes	ACTIVE	2023-03-09T09:21:40Z	2		    2		    2			t2.micro	    AL2_x86_64	eks-alpine-nodes-74c362d6-871f-063a-b491-5cdb41bd71f1	managed'


kubectl run alpine-1 --image=alpine     --> will create an alpine imaged POD

kubectl run alpine-1 --image=alpine --tty -i  -> will create and enter into the POD interactively


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
