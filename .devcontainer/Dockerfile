# Define global arguments (can be overridden during build)
ARG UBUNTU_VERSION=24.04
ARG PYTHON_VERSION=3.13
ARG USERNAME=Yas

FROM ubuntu:${UBUNTU_VERSION}

# Re-declare ARGs after FROM to make them available in this stage
ARG PYTHON_VERSION
ARG USERNAME
ARG USER_UID=1001
ARG USER_GID=$USER_UID

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install prerequisites and PPA
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    ca-certificates \
    curl \
    git \
    sudo \
    && add-apt-repository ppa:deadsnakes/ppa -y

# 2. Install Python versions dynamically
# Use rm -rf /var/lib/apt/lists/* which is standard practice to keep Docker images lightweight.
RUN apt-get update && apt-get install -y --no-install-recommends \
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-dev \
    python${PYTHON_VERSION}-nogil \
    vim make zip tree wget jq gcc libc6-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. Set the GIL version as the default 'python3'. 
# Use --set flag to guarantee that /usr/bin/python3 points to the standard GIL version.
# No-GIL binary is identified as python3.13t
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PYTHON_VERSION} 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PYTHON_VERSION}t 2 && \
    update-alternatives --set python3 /usr/bin/python${PYTHON_VERSION}

# 4. Install Pip for both (Standard and No-GIL)
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python${PYTHON_VERSION} && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python${PYTHON_VERSION}t

# 5. User Setup
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
# Add the local pip bin folder to the system PATH
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"
WORKDIR /home/project

# Install kernel for the specific version. Use --no-cache-dir when installing packages to prevent the image from bloating with temporary download files
# RUN python3 -m pip install --no-cache-dir ipykernel

ENV TERM=xterm-256color
CMD ["sleep", "infinity"]