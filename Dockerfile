FROM ubuntu:16.04
ARG DOWNLOAD_LINK=https://apt.repos.intel.com/openvino/2019/GPG-PUB-KEY-INTEL-OPENVINO-2019
ARG INSTALL_DIR=/opt/intel/openvino
ARG TEMP_DIR=/tmp/openvino_installer
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    cpio \
    apt-transport-https ca-certificates \
    sudo \
    lsb-release && \
    rm -rf /var/lib/apt/lists/*
RUN wget --no-check-certificate $DOWNLOAD_LINK && sudo apt-key add GPG-PUB-KEY-INTEL-OPENVINO-2019 && sudo apt-key list
RUN touch intel-openvino-2019.list && echo "deb https://apt.repos.intel.com/openvino/2019/ all main" >>  intel-openvino-2019.list && sudo cp intel-openvino-2019.list /etc/apt/sources.list.d/intel-openvino-2019.list && apt-get update
RUN sudo apt install -y --no-install-recommends intel-openvino-dev-ubuntu16
RUN $INSTALL_DIR/install_dependencies/install_openvino_dependencies.sh
# build Inference Engine samples
RUN $INSTALL_DIR/inference_engine/demos/build_demos.sh
