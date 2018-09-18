#!/bin/sh

##
## Grant cluster-admin role to current gcloud user
##

set -euo pipefail

# Unset previous gke entries and authenticate again with current gcloud user
kubectl config unset contexts.`kubectl config view -o json | jq -re .contexts[].name | grep gke-cluster`
kubectl config unset users.`kubectl config view -o json | jq -re .users[].name | grep gke-cluster`
kubectl config unset clusters.`kubectl config view -o json | jq -re .clusters[].name | grep gke-cluster`
gcloud container clusters get-credentials gke-cluster

TF_DIR="../cluster-configuration"
K8S_USERNAME=`(cd ${TF_DIR} && terraform output -module=gke k8s_username)`
K8S_PASSWORD=`(cd ${TF_DIR} && terraform output -module=gke k8s_password)`
CLUSTER_NAME=`kubectl config view -o json | jq -re .clusters[].name | grep gke-cluster`
ORIGINAL_CONTEXT=`kubectl config current-context`
RANDOM=`openssl rand -hex 3`
GCLOUD_USER=`gcloud info --format="value(config.account)"`

kubectl config set-credentials catalog-admin-user --username=${K8S_USERNAME} --password=${K8S_PASSWORD}
kubectl config set-context catalog-admin --cluster=${CLUSTER_NAME} --user=catalog-admin-user
kubectl config use-context catalog-admin

kubectl create clusterrolebinding cluster-admin-binding-${RANDOM} --clusterrole=cluster-admin --user=${GCLOUD_USER}

kubectl config unset contexts.catalog-admin
kubectl config unset users.catalog-admin-user

kubectl config use-context ${ORIGINAL_CONTEXT}
