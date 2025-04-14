include .env

IMAGE_NAME=lapierre/flyway
IMAGE_VERSION=$(FLYWAY_VERSION)

build:
	docker build --pull --build-arg FLYWAY_VERSION=$(FLYWAY_VERSION) -t $(IMAGE_NAME):$(IMAGE_VERSION) .
	docker tag $(IMAGE_NAME):$(IMAGE_VERSION) $(IMAGE_NAME):latest
	docker tag $(IMAGE_NAME):$(IMAGE_VERSION) $(IMAGE_NAME):7

push:
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)
	docker push $(IMAGE_NAME):latest
	docker push $(IMAGE_NAME):7

github:
	docker buildx build --build-arg FLYWAY_VERSION=$(FLYWAY_VERSION) --platform linux/arm64/v8,linux/amd64 \
 		--tag "$(IMAGE_NAME):21" --tag "$(IMAGE_NAME):$(IMAGE_VERSION)" \
 		--output "type=image,push=true" .