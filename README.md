# catalog [![pipeline status](https://gitlab.com/slamdev/catalog/badges/master/pipeline.svg)](https://gitlab.com/slamdev/catalog/pipelines)

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

- :white_check_mark: [Gitlab CI](https://about.gitlab.com/features/gitlab-ci-cd/) with :question: [Review Apps](https://about.gitlab.com/features/review-apps/) support
- :white_check_mark: [K8S Gitlab Runner](https://docs.gitlab.com/runner/install/kubernetes.html)

## Tools

- :white_check_mark: [Makefile](https://www.gnu.org/software/make/manual/make.html) orchestrates build\deploy process
- :white_check_mark: [Kustomize](https://github.com/kubernetes-sigs/kustomize) and :white_check_mark: [Skaffold](https://github.com/GoogleContainerTools/skaffold) manage k8s manifests

### Infrastructure

- :white_check_mark: Managed [Kubernetes](https://kubernetes.io/) instance in [Google Cloud](https://cloud.google.com/kubernetes-engine/) 
- :white_check_mark: [Terraform](https://www.terraform.io/) scripts to create Kubernetes cluster
- :white_check_mark: [Ambassador](https://www.getambassador.io/) API gateway
- [Istio](https://istio.io/) service mesh
- [NATS](https://nats.io/) event bus
- [CockroachDB](https://www.cockroachlabs.com/) relation database
- [Prometheus](https://prometheus.io/) and [Grafana](https://grafana.com/) metric based monitoring
- [Sentry](https://sentry.io/) application error monitoring
- [ELK](https://www.elastic.co/elk-stack) logs viewer

### Frontend

- :white_check_mark: [React](https://reactjs.org/) based :question: [micro frontends](https://micro-frontends.org/)
- :white_check_mark: [Webpack](https://webpack.js.org/)
- :white_check_mark: [Lerna](https://github.com/lerna/lerna)
- :white_check_mark: [Material UI](https://material-ui.com/) styles
- :white_check_mark: [GRPC Web](https://github.com/grpc/grpc-web) communication layer with backend

### Backend

- [GRPC](https://grpc.io/) communication layer between services
- [GRPC Healthcheck](https://github.com/grpc-ecosystem/grpc-health-probe/) for K8S readiness and liveness probes

#### Java

- :white_check_mark: [Java](http://jdk.java.net/) microservices based on :white_check_mark: [Spring Boot](http://spring.io/projects/spring-boot)
- :white_check_mark: [Gradle](https://gradle.org/)

#### Golang

- [Golang](https://golang.org/) microservices
- [Go Modules](https://github.com/golang/go/wiki/Modules)

## Development environment

Configure **kubectl**:
```bash
PROJECT_ID=`gcloud projects list --filter="name=catalog" --format="get(project_id)"`
gcloud config set project ${PROJECT_ID}
ZONE=`gcloud container clusters list --filter="name=gke-cluster" --format="get(zone)"`
gcloud config set compute/zone ${ZONE}
gcloud container clusters get-credentials gke-cluster
```
