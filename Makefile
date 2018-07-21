IMAGE_NAME    ?= edentsai/edentsai-workspace
IMAGE_VERSION ?= latest
IMAGE_EXISTS  := $(shell docker image ls --quiet --filter "reference=$(IMAGE_NAME):$(IMAGE_VERSION)" | wc -l)

TIMEZONE ?= Asia/Taipei
USERNAME ?= $(shell whoami)
PASSWORD ?= secret
PUID     ?= 1000
PGID     ?= 1000

GO_VERSION ?= 1.10.3

.PHONY: all docker-build docker-run docker-push docker-clean

all: docker-build

docker-build:
	docker build --force-rm \
		--tag "$(IMAGE_NAME):$(IMAGE_VERSION)" \
		--build-arg "TIMEZONE=${TIMEZONE}" \
		--build-arg "USERNAME=${USERNAME}" \
		--build-arg "PASSWORD=${PASSWORD}" \
		--build-arg "PUID=${PUID}" \
		--build-arg "PGID=${PGID}" \
		--build-arg "GO_VERSION=${GO_VERSION}" \
		./workspace

docker-run:
ifeq ("$(IMAGE_EXISTS)", "0")
	make build || exit "$$?";
endif
	docker run --rm --interactive --tty --user "$(USERNAME)" "$(IMAGE_NAME):$(IMAGE_VERSION)" "/bin/bash"

docker-push:
ifeq ("$(IMAGE_EXISTS)", "0")
	echo "Push failed: the image '$(IMAGE_NAME):$(IMAGE_VERSION)' not exists"
	exit 1
endif
	docker push "$(IMAGE_NAME):$(IMAGE_VERSION)"

docker-clean:
	docker image prune --force
