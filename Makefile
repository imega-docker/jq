BUILDER_VER = 1.9.0
IMAGE=imega/jq
TAG=latest

build: buildfs test
	@docker build -t $(IMAGE):$(TAG) .
	@docker tag $(IMAGE):$(TAG) $(IMAGE):latest

buildfs:
	@docker run --rm \
		-v $(CURDIR)/build:/build \
		imega/base-builder:$(BUILDER_VER) \
		--packages="jq@edge-main"

test:
	@docker build -t $(IMAGE):test .
	@echo '{"foo":10, "bar":200}' | docker run --rm -i imega/jq:test '.bar as $$x | .foo | . + $$x' | grep 210

release:
	@docker login --username $(DOCKER_USER) --password $(DOCKER_PASS)
	@docker push $(IMAGE):$(TAG)
	@docker push $(IMAGE):latest

.PHONY: build
