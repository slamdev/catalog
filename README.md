# catalog

AIM of the project is to show how different technologies can be integrated to build an application.

## Business requirements

Application provides basic catalog\shopping cart functionality with the followin features:
- user can register or login
- anonymous user can view list of products in a catalog
- authenticated user can add a product to favorites list
- authenticated user can remove products from list of favorites

Design mock: https://ninjamock.com/s/LVD5BTx

## Technologies

Project has monorepo structure.

### CI

- [Gitlab CI](https://about.gitlab.com/features/gitlab-ci-cd/) with [Review Apps](https://about.gitlab.com/features/review-apps/) support
- [K8S Gitlab Runner](https://docs.gitlab.com/runner/install/kubernetes.html)

## Tools

- [Makefile](https://www.gnu.org/software/make/manual/make.html) orchestrates build\deploy process
- [Kustomize](https://github.com/kubernetes-sigs/kustomize) and [Skaffold](https://github.com/GoogleContainerTools/skaffold) manage k8s manifests

### Infrastructure

- Managed [Kubernetes](https://kubernetes.io/) instance in [Google Cloud](https://cloud.google.com/kubernetes-engine/) 
- [Terraform](https://www.terraform.io/) scripts to create Kubernetes cluster
- [Ambassador](https://www.getambassador.io/) API gateway
- [Istio](https://istio.io/) service mesh
- [NATS](https://nats.io/) event bus
- [CockroachDB](https://www.cockroachlabs.com/) relation database
- [Prometheus](https://prometheus.io/) and [Grafana](https://grafana.com/) metric based monitoring
- [Sentry](https://sentry.io/) application error monitoring
- [ELK](https://www.elastic.co/elk-stack) logs viewer

### Frontend

- [React](https://reactjs.org/) based micro frontends
- [Webpack](https://webpack.js.org/)
- [Material UI](https://material-ui.com/) styles
- [GRPC Web](https://github.com/grpc/grpc-web) communication layer with backend

### Backend

- [GRPC](https://grpc.io/) communication layer between services

#### Java

- [Java](http://jdk.java.net/) microservices based on [Spring Boot](http://spring.io/projects/spring-boot)
- [Gradle](https://gradle.org/)

#### Golang

- [Golang](https://golang.org/) microservices
- [Go Modules](https://github.com/golang/go/wiki/Modules)
