# Cluster configuration

Configuration of the Google Kubernetes Engine cluster via terraform.

## Prerequisite

[google-cloud-sdk](https://cloud.google.com/sdk/install) should be installed and user should be authenticated there.

```bash
gcloud auth login
```

User should have **Project Creator** role.

## Terraform backend

Terraform backend is stored as a separate project in Google Cloud. The `create-backend-project.sh` script creates it.

Also script creates **terraform** service account that will execute terraform files.

## Create\update cluster

### Prerequisite

Before running terraform, **backend.tfvars** and **terraform.tfvars** should be created. The `populate-tfvars.sh` script 
populates them. Script requires kubernetes **username** and **password** as input parameters, e.g.:

```bash
./populate-tfvars.sh admin q1w2e3r4t5y6
```

### Run terraform

Initial creation can take a while, up to 10 minutes.

```bash
./configure-cluster.sh
```

## Destroy cluster

```bash
./destroy-cluster.sh
```

## Remove terraform backend

```bash
./destroy-backend-project.sh
```
