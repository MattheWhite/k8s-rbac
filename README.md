<a name="readme-top"></a>

# Kubernetes Role-Based Access Control (k8s RBAC)

[![Contributors][contributors-shield]][contributors-url]

![Kuvernetes](https://i0.wp.com/softwareengineeringdaily.com/wp-content/uploads/2019/01/Kubernetes_New.png?resize=730%2C389&ssl=1)


## About the project

As your Kubernetes knowledge grows and you start to use your knowledge for more and more, it would be worth looking into how you can limit what certain users and processes can do inside your cluster for security purposes.

Several building blocks and technologies related to Docker are present in this learning project:
* How to limit what users and processes are able to do inside a cluster


## Built With

[![Kubernetes][kubernetes-shield]][kubernetes-url]
[![Nginx][nginx-shield]][nginx-url]


<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Tasks of the Project
The necessary commands with explanation comment lines can be find in `commands.sh` file!
Under the flask-nginx-docker folder you will find all the necessary files to be able to build the Docker image what is used in the project for deploying containers.

According to the build of a Docker image, you can find all the commands with instructions collected inside the `commands-deploy-application.sh` file. As the name suggests, there are commands to explain how to start and stop an nginx server too.

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
* Minikube

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Hints

- Kubectl Docker Image: https://hub.docker.com/r/bitnami/kubectl/
- Kubectl has a few commands that are very similar to Docker ones. For example, the ```kubectl exec -it mongo-pod -- bash -c "mongo"``` command is the Kubernetes counterpart of ```docker exec -it <CONTAINER_ID> mongo```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Background materials

- <i class="far fa-exclamation"></i> [Kubernetes Service Accounts](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)
- <i class="far fa-exclamation"></i> [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Contact

MattheWhite - Fehér Mátyás

[![LinkedIn][linkedin-shield]][linkedin-url]
[![GitHub][github-shield]][github-url]

Project Link: [https://github.com/MattheWhite/docker-networking](https://github.com/MattheWhite/docker-networking)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


[contributors-shield]: https://img.shields.io/github/contributors/MattheWhite/k8s-rbac.svg?style=for-the-badge
[contributors-url]: https://github.com/MattheWhite/k8s-rbac
[kubernetes-shield]: https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white
[kubernetes-url]: https://kubernetes.io/docs/home/
[nginx-shield]: https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white
[nginx-url]: https://www.nginx.com/
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=349
[linkedin-url]: https://www.linkedin.com/in/matyas-feher/
[github-shield]: https://img.shields.io/badge/-GitHub-black.svg?style=for-the-badge&logo=github&colorB=947
[github-url]: https://github.com/MattheWhite