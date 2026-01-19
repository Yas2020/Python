# The Skills Network Cloud IDE uses Ubuntu 18.04 :(
    FROM ubuntu:24.04

    ENV DEBIAN_FRONTEND=noninteractive

    RUN apt-get update && \
        apt-get install -y software-properties-common dirmngr apt-transport-https lsb-release ca-certificates && \
        add-apt-repository ppa:deadsnakes
        

    # Add any tools that are needed
    RUN apt update && \
        apt install -y sudo \
            vim \
            make \
            git \
            zip \
            tree \
            curl \
            wget \
            jq 
            # redis-server
    
    # Install Python3.13 free-thresding (no-gil) as the default Python3 
    RUN apt install -y python3.13-nogil
    RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13t 1 && \
        apt autoremove -y && \
        apt clean -y
    
    # Create a user for development
    ARG USERNAME=Yas
    ARG USER_UID=1001
    ARG USER_GID=$USER_UID
    
    # Create the user with passwordless sudo privileges
    RUN groupadd --gid $USER_GID $USERNAME \
        && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
        && usermod -aG sudo $USERNAME \
        && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
        && chmod 0440 /etc/sudoers.d/$USERNAME
    
    # Set up the Python development environment
    WORKDIR /home/project
    # install pip for defualt python runtime which is python3.13t
    RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3
    RUN apt install -y gcc python3.13-dev
    # Also install pip for the normal python3.13 (with gil) 
    RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.13
    # RUN python3 -m pip install ipykernel --user --force-reinstall
    # RUN /usr/bin/python3 -m pip install --upgrade pip && \
        # /usr/bin/python3 -m pip install ipykernel --user --force-reinstall
        # python3 -m pip install --upgrade pipenv virtualenv
    # RUN python3 -m  pip install --upgrade pip && \
    #     pip3 install --upgrade wheel 

    # install redis docker container
    # RUN docker run -d --name my-redis-stack -p 6379:6379  redis/redis-stack-server:latest
 
    ENV PORT 8000
    EXPOSE $PORT
    
    # Enable color terminal for docker exec bash
    ENV TERM=xterm-256color
    
    # Become a regular user
    USER $USERNAME  
