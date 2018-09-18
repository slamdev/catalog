#!/bin/sh

set -euo pipefail

GENERATED_CREDENTIALS="credentials.json"

terraform destroy
rm -rf .terraform/
rm -f terraform.tfvars
rm -f backend.tfvars
rm -f tfplan
rm -f ${GENERATED_CREDENTIALS}
