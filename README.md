<a name="readme-top"></a>

# Kubernetes Role-Based Access Control (k8s RBAC)

[![Contributors][contributors-shield]][contributors-url]

![Kubernetes](https://i0.wp.com/softwareengineeringdaily.com/wp-content/uploads/2019/01/Kubernetes_New.png?resize=730%2C389&ssl=1)


## About the project

### Kubernetes
- Kubernetes, an extremely popular orchestration tool for containers, has a lot of moving pieces to worry about – and that’s before you even get to see a “Hello World” app. AWS’ managed Kubernetes service, EKS (Elastic Kubernetes Service), is a great option, and facilitates access to other AWS services like IAM, AutoScaling, and CloudWatch.

- Kubernetes is a portable, extensible, open source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation. It has a large, rapidly growing ecosystem. Kubernetes services, support, and tools are widely available.


### Kubernetes and Docker
- The difference between Kubernetes and Docker is more easily understood when framed as a “both-and” question. The fact is, you do not have to choose—Kubernetes and Docker are fundamentally different technologies that work well together for building, delivering and scaling containerised apps.


### Helm
- Helm helps you manage Kubernetes applications — Helm Charts help you define, install, and upgrade even the most complex Kubernetes application.

- Charts are easy to create, version, share, and publish — so start using Helm and stop the copy-and-paste.

Not necessary for the project, although a very useful tool when you operate with Kubernetes.
The following prerequisites are required for a successful and properly secured use of Helm.
* A Kubernetes cluster
* Deciding what security configurations to apply to your installation, if any
* Installing and configuring Helm.


In this project I was using AWS EKS to create and manage a cluster in the cloud, but for learning purposes you can use Minikube to simulate a cluster on your local machine too.

`Although one tool is a must and that is kubectl !`

`The Kubernetes command-line tool, kubectl, allows you to run commands against Kubernetes clusters. You can use kubectl to deploy applications, inspect and manage cluster resources, and view logs.`

After you Kubernetes knowledge grows and you've mastered the basics, it would be worth looking into how you can limit what certain users and processes can do inside your cluster for security purposes.

Several building blocks and technologies related to Docker are present in this learning project:
* How to limit what users and processes are able to do inside a cluster
* How to create Roles, ServiceAccounts in Kubernetes
* How to bind them together to limit the given K8s Object/Resource's capabilities with Role Binding

As I mentioned above, Minikube is a great tool for creating a cluster locally on your machine, if you have no resource to create one in the clouds (for example: AWS EKS -> Amazon Web Services - Elastic Kubernetes Service).


## Built With

[![Kubernetes][kubernetes-shield]][kubernetes-url]
[![Nginx][nginx-shield]][nginx-url]
[![Helm][helm-shield]][helm-url]


<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Tasks of the Project
The necessary commands with explanation comment lines can be find in `commands.sh` file!
Under the flask-nginx-docker folder you will find all the necessary files to be able to build the Docker image what is used in the project for deploying containers.

You can find a ```helm-rbac-commands.sh``` script file, within I installed and used some Helm Chart and worked with that. Not necessary to the project but it was useful to understand Helm Charts/Templates too.


1. Create a Service Account for your Cluster
    - Your Service Account can be seen when you ask for information about the Service Accounts in your Cluster

2. Create a Role that only lets the interaction of Pods
    - Your Role is created on the Cluster

3. Attach a Role Binding to the Service Account
    - Your Role Binding is successfully created

4. Create a Pod based on an Image that contains the Kubectl command and attach the Service Account to this Pod, then connect to it
    - You successfully connected to your Pod

5. Try to create a service for Nginx, if the service account is working, then you wont be able to, since it is not defined in the role that you can create it
    - The Nginx service is not created

6. Try to create a pod. You should be able to create this, since the role contains the ability to interact with Pods
    - The Pod is created

7. Try to create a pod again, however, it should be in another namespace
    - The Pod is not created, because that would need a Cluster Role instead of a regular one

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## General requirements

* Kubernetes
* Kubectl - As mentioned above this command-line tool is necessary
* Minikube (or a Cloud Provider with Kubernetes Service, like AWS EKS)

_More about starting with Minikube: https://minikube.sigs.k8s.io/docs/start/_

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Hints

- Kubectl Docker Image: https://hub.docker.com/r/bitnami/kubectl/
- Kubectl has a few commands that are very similar to Docker ones. For example, the ```kubectl exec -it mongo-pod -- bash -c "mongo"``` command is the Kubernetes counterpart of ```docker exec -it <CONTAINER_ID> mongo```
- Set which Kubernetes cluster kubectl communicates with and modifies configuration information.
```sh
kubectl config view                           # Show Merged kubeconfig settings.

kubectl config set-cluster my-cluster-name    # set a cluster entry in the kubeconfig
```
- `Easiest way to create a Kubernetes Resource in the Cluster with mangaing it's state and changing is using manifest files!`
```apply``` manages applications through files defining Kubernetes resources. It creates and updates resources in a cluster through running kubectl apply. This is the recommended way of managing Kubernetes applications on production.
Kubernetes manifests can be defined in YAML or JSON. The file extension .yaml, .yml, and .json can be used.
```sh
kubectl apply -f ./my-manifest.yaml            # create resource(s)
```

_More about managing resources: https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/_

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Background materials

- <i class="far fa-exclamation"></i> [Kubernetes Overview](https://kubernetes.io/docs/concepts/overview/)
- <i class="far fa-exclamation"></i> [Kubernetes CheatSheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- <i class="far fa-exclamation"></i> [Kubernetes Service Accounts](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)
- <i class="far fa-exclamation"></i> [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- <i class="far fa-exclamation"></i> [Helm Quickstart](https://helm.sh/docs/intro/quickstart/)
- <i class="far fa-exclamation"></i> [Short summary about using Helm Charts](https://circleci.com/blog/what-is-helm/?utm_source=google&utm_medium=sem&utm_campaign=sem-google-dg--emea-en-dsa-tROAS-auth-nb&utm_term=g_-_c__dsa_&utm_content=&gclid=CjwKCAjw586hBhBrEiwAQYEnHQTS-SSBZyYAWOX1vaBkvgi50iShkIfQ7veLTZGdTcBzr3E5wYeZ7hoCkEMQAvD_BwE)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Contact

MattheWhite - Fehér Mátyás

[![LinkedIn][linkedin-shield]][linkedin-url]
[![GitHub][github-shield]][github-url]

Project Link: [https://github.com/MattheWhite/docker-networking](https://github.com/MattheWhite/k8s-rbac)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


[contributors-shield]: https://img.shields.io/github/contributors/MattheWhite/k8s-rbac.svg?style=for-the-badge
[contributors-url]: https://github.com/MattheWhite
[kubernetes-shield]: https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white
[kubernetes-url]: https://kubernetes.io/docs/home/
[nginx-shield]: https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white
[nginx-url]: https://www.nginx.com/
[helm-shield]: https://img.shields.io/badge/helm-blue?logo=helm&style=for-the-badge
[helm-url]: https://helm.sh/
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=349
[linkedin-url]: https://www.linkedin.com/in/matyas-feher/
[github-shield]: https://img.shields.io/badge/-GitHub-black.svg?style=for-the-badge&logo=github&colorB=947
[github-url]: https://github.com/MattheWhite
