IMAGE_NAME    ?= edentsai/edentsai-workspace
IMAGE_VERSION ?= latest
IMAGE_EXISTS  := $(shell docker image ls --quiet --filter "reference=$(IMAGE_NAME):$(IMAGE_VERSION)" | wc -l)

.PHONY: all docker-build docker-run docker-push

all: docker-build

docker-build:
	docker build --force-rm \
		--tag "$(IMAGE_NAME):$(IMAGE_VERSION)" \
		./workspace

docker-run:
ifeq ("$(IMAGE_EXISTS)", "0")
	make build || exit "$$?";
endif
	docker run --rm --interactive --tty "$(IMAGE_NAME):$(IMAGE_VERSION)" "/bin/bash"

docker-push:
ifeq ("$(IMAGE_EXISTS)", "0")
	echo "Push failed: the image '$(IMAGE_NAME):$(IMAGE_VERSION)' not exists"
	exit 1
endif
	docker push "$(IMAGE_NAME):$(IMAGE_VERSION)"
