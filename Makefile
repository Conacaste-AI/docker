.PHONY build-ubuntu-cpu-x86_64:
build-ubuntu-cpu-x86_64:
	@IMAGE_FROM=${IMAGE_FROM}
	@TARGET=${TARGET}
	cd ${DOCKER_SCRIPTS}

	echo "Building image for ${TARGET} with base image ${IMAGE_FROM}"

	DOCKER_BUILDKIT=1 docker build \
		--network=host \
		-f Dockerfile \
		--target ${TARGET} \
		--build-arg BASE_FROM=${IMAGE_FROM} \
		--build-arg APT_PACKAGES=empty-packages \
		--build-arg BASH_SETTINGS_FILE=base.sh \
		--build-arg CUSTOM_INSTALL_FILE=empty-install.sh \
		--build-arg PIP_PACKAGES=empty-packages \
		--build-arg PIP_GPU_PACKAGES=empty-packages \
		--build-arg TEST_INSTALL_FILE=empty-layer.sh \
		--build-arg ROS_INSTALL_FILE=ubuntu-iron-apt.sh \
		-t ghcr.io/conacaste-ai/robocar:ubuntu-x86_64-${TARGET} .

.PHONY build-ubuntu-gpu-l4t:
build-ubuntu-gpu-l4t:
	@IMAGE_FROM=${IMAGE_FROM}
	@TARGET=${TARGET}
	cd ${DOCKER_SCRIPTS}

	echo "Building image for ${TARGET} with base image ${IMAGE_FROM}"

	DOCKER_BUILDKIT=1 docker build \
		--network=host \
		-f Dockerfile \
		--target ${TARGET} \
		--build-arg BASE_FROM=${IMAGE_FROM} \
		--build-arg APT_PACKAGES=jetson-ros-packages \
		--build-arg BASH_SETTINGS_FILE=jetson-ros \
		--build-arg CUSTOM_INSTALL_FILE=jetson-ros-install.sh \
		--build-arg PIP_PACKAGES=jetson-ros \
		--build-arg PIP_GPU_PACKAGES=jetson-ros \
		--build-arg TEST_INSTALL_FILE=empty-layer.sh \
		--build-arg ROS_INSTALL_FILE=ubuntu-iron-apt.sh \
		-t ghcr.io/conacaste-ai/robocar:ubuntu-l4t-${TARGET} .

.PHONY build-ubuntu-gpu-orin:
build-ubuntu-gpu-orin:
	@IMAGE_FROM=${IMAGE_FROM}
	@TARGET=${TARGET}
	cd ${DOCKER_SCRIPTS}

	echo "Building image for ${TARGET} with base image ${IMAGE_FROM}"

	DOCKER_BUILDKIT=1 docker build \
		--network=host \
		-f Dockerfile \
		--target ${TARGET} \
		--build-arg BASE_FROM=${IMAGE_FROM} \
		--build-arg APT_PACKAGES=jetson-ros-packages \
		--build-arg BASH_SETTINGS_FILE=jetson-ros \
		--build-arg CUSTOM_INSTALL_FILE=jetson-ros-install.sh \
		--build-arg PIP_PACKAGES=jetson-ros \
		--build-arg PIP_GPU_PACKAGES=jetson-orin-ros \
		--build-arg TEST_INSTALL_FILE=empty-layer.sh \
		--build-arg ROS_INSTALL_FILE=ubuntu-iron-apt.sh \
		-t ghcr.io/conacaste-ai/robocar:ubuntu-orin-${TARGET} .

.PHONY run-ubuntu-gpu-orin:
run-ubuntu-gpu-orin:
	@TARGET=${TARGET}

	docker run -it --rm \
		--runtime nvidia \
		--net=host \
		--volume ~/moises/robocar:/robocar \
		--name robocar-ubuntu-l4t-${TARGET} \
		ghcr.io/conacaste-ai/robocar:ubuntu-orin-${TARGET}

.PHONY run-ubuntu-gpu-l4t:
run-ubuntu-gpu-l4t:
	@TARGET=${TARGET}

	docker run -it --rm \
		--runtime nvidia \
		--net=host \
		--volume ~/conacaste/robocar:/robocar \
		--name robocar-ubuntu-l4t-${TARGET} \
		ghcr.io/conacaste-ai/robocar:ubuntu-l4t-${TARGET}

.PHONY push-ubuntu-gpu-l4t:
push-ubuntu-gpu-l4t:
	@TARGET=${TARGET}

	docker push ghcr.io/conacaste-ai/robocar:ubuntu-l4t-${TARGET}

.PHONY pull-ubuntu-gpu-l4t:
pull-ubuntu-gpu-l4t:
	@TARGET=${TARGET}

	docker pull ghcr.io/conacaste-ai/robocar:ubuntu-l4t-${TARGET}

.PHONY run-ubuntu-cpu-x86_64:
run-ubuntu-cpu-x86_64:
	@TARGET=${TARGET}

	sudo docker run -it --rm \
		--net=host \
		--name robocar-ubuntu-x86_64-${TARGET} \
		ghcr.io/conacaste-ai/robocar:ubuntu-x86_64-${TARGET}

.PHONY push-ubuntu-cpu-x86_64:
push-ubuntu-cpu-x86_64:
	@TARGET=${TARGET}

	docker push ghcr.io/conacaste-ai/robocar:ubuntu-x86_64-${TARGET}