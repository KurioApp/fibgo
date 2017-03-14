IMAGE_NAME=fibgo
GCLOUD_REGISTRY_PREFIX=asia.gcr.io/kurio-dev
GCLOUD_CLUSTER_NAME=fibgo-cluster-stg
GCLOUD_PROJECT_NAME=kurio-dev
GCLOUD_ZONE=asia-east1-a

install:
	@go install ./...

prepare-install:
	@go get -v

test:
	@go test

test-all:
	@go test -cover -bench .

check:
	@gometalinter --deadline=15s

prepare-check:
	@go get -u github.com/alecthomas/gometalinter
	@gometalinter --install

docker-build:
	@docker build -t $(IMAGE_NAME) .

docker-run:
	@docker run --rm -it -p 8080:8080 $(IMAGE_NAME)

docker-console:
	@docker run --rm -it -p $(IMAGE_NAME) /bin/sh

init-config:
	@gcloud auth activate-service-account --key-file kurio-gcp.json
	@gcloud --quiet config set project $(GCLOUD_PROJECT_NAME)
	@gcloud --quiet config set compute/zone $(GCLOUD_ZONE)

init-cluster-stg:
	@gcloud container --project "$(GCLOUD_PROJECT_NAME)" clusters create "$(GCLOUD_CLUSTER_NAME)" --zone "$(GCLOUD_ZONE)" --machine-type "n1-standard-1" --image-type "GCI" --disk-size "100" --scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "1" --network "default" --enable-cloud-logging --enable-cloud-monitoring

init-image-stg:
	@docker tag $(IMAGE_NAME) $(GCLOUD_REGISTRY_PREFIX)/fibgo-stg
	@gcloud docker -- push $(GCLOUD_REGISTRY_PREFIX)/fibgo-stg

init-deployment-stg:
	@gcloud --quiet config set container/cluster $(GCLOUD_CLUSTER_NAME)
	@gcloud --quiet container clusters get-credentials $(GCLOUD_CLUSTER_NAME)
	@kubectl create -f fibgo-app-stg.yaml --record

init-cloud: init-config init-cluster-stg docker-build init-image-stg init-deployment-stg
