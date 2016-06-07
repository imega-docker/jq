# Build rootfs

build: build-fs
	@docker build -t imega/jq .

build-fs:
	@docker run --rm \
		-v $(CURDIR)/build:/build \
		imega/base-builder:1.1.1 \
		--packages="jq"

.PHONY: build
