FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
        curl make build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        llvm \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libffi-dev \
        liblzma-dev \
        git dos2unix unzip zip

ENV PYENV_ROOT /pyenv
RUN git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT

ARG PYTHON_VERSION=3.8
ENV PYTHON_VERSION=$PYTHON_VERSION

RUN /pyenv/bin/pyenv install $PYTHON_VERSION
COPY requirements.txt .

RUN --mount=type=cache,target=/root/.cache eval "$(/pyenv/bin/pyenv init -)" && \
        /pyenv/bin/pyenv local $PYTHON_VERSION && \
        pip install --upgrade pip && \
        pip install -r requirements.txt && \
        /pyenv/bin/pyenv rehash

RUN curl -s "https://get.sdkman.io" | bash

# Installing Java and Maven, removing some unnecessary SDKMAN files 
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    yes | sdk install java 17.0.10-tem && \
    rm -rf $HOME/.sdkman/archives/* && \
    rm -rf $HOME/.sdkman/tmp/*"

ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"

RUN apt update && apt install -y default-jre-headless
RUN wget https://github.com/allure-framework/allure2/releases/download/2.27.0/allure_2.27.0-1_all.deb &&  dpkg -i allure_2.27.0-1_all.deb
COPY env.sh /app/env.sh
RUN chmod +x /app/env.sh
RUN dos2unix /app/env.sh

WORKDIR /app
SHELL  [ "/bin/bash", "-c", "source /app/env.sh"]
