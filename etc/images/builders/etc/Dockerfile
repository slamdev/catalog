FROM asia.gcr.io/catalog-8c920686/builder-base

ENV PATH /google-cloud-sdk/bin:$PATH
ENV CLOUD_SDK_VERSION=217.0.0
ENV TERRAFORM_VERSION=0.11.8

RUN apk upgrade --no-cache \
# Install common tools
 && apk add --no-cache python py-crcmod libc6-compat openssh-client gnupg \
# install Google Cloud SDK
 && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
 && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
 && rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
 && ln -s /lib /lib64 \
 && gcloud config set core/disable_usage_reporting true \
 && gcloud config set component_manager/disable_update_check true \
 && gcloud config set metrics/environment github_docker_image \
 && gcloud components install beta --quiet \
 && gcloud --version \
# Install Terraform
 && curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
 && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin \
 && rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
