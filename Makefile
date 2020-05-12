BUILDER_IMG = imega/base-builder:1.9.2
IMAGE=imega/jq
TAG=latest
ARCH=$(shell uname -m)

ifeq ($(ARCH),aarch64)
        ARCH=arm64
endif

ifeq ($(ARCH),x86_64)
        ARCH=amd64
endif

build: buildfs test
	@docker build -t $(IMAGE):$(TAG)-$(ARCH) .
	@docker tag $(IMAGE):$(TAG)-$(ARCH) $(IMAGE):latest-$(ARCH)

buildfs:
	@docker run --rm \
		-v $(CURDIR)/build:/build \
		$(BUILDER_IMG) \
		--packages="jq@edge-main"

test:
	@docker build -t $(IMAGE):test .
	@echo '{"foo":10, "bar":200}' | docker run --rm -i $(IMAGE):test '.bar as $$x | .foo | . + $$x' | grep 210

login:
	@docker login --username $(DOCKER_USER) --password $(DOCKER_PASS)

release: login
	@docker push $(IMAGE):$(TAG)-$(ARCH)
	@docker push $(IMAGE):latest-$(ARCH)

release-manifest: login
	@docker manifest create $(IMAGE):$(TAG) $(IMAGE):$(TAG)-amd64 $(IMAGE):$(TAG)-ppc64le $(IMAGE):$(TAG)-arm64
	@docker manifest create $(IMAGE):latest $(IMAGE):latest-amd64 $(IMAGE):latest-ppc64le $(IMAGE):latest-arm64
	@docker manifest push $(IMAGE):$(TAG)
	@docker manifest push $(IMAGE):latest
