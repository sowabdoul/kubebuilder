IMAGE ?= your-dockerhub-user/kubebuilder
VERSION ?= dev
PLATFORMS ?= linux/amd64,linux/arm64

.PHONY: build test login push multiarch

build:
	docker build \
	  --build-arg GO_VERSION=1.26 \
	  --build-arg KIND_VERSION=v0.30.0 \
	  --build-arg KUBECTL_VERSION=v1.33.0 \
	  -t $(IMAGE):$(VERSION) .

test:
	docker run --rm $(IMAGE):$(VERSION) sh -ec '\
	  go version; \
	  docker --version; \
	  kind version; \
	  kubectl version --client; \
	  make --version | head -n 1'

login:
	docker login

push: build test
	docker push $(IMAGE):$(VERSION)

multiarch:
	docker buildx build \
	  --platform $(PLATFORMS) \
	  --build-arg GO_VERSION=1.26 \
	  --build-arg KIND_VERSION=v0.30.0 \
	  --build-arg KUBECTL_VERSION=v1.33.0 \
	  -t $(IMAGE):$(VERSION) \
	  --push .
