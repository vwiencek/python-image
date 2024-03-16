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
        git

ENV PYENV_ROOT /pyenv
RUN git clone https://github.com/pyenv/pyenv.git /pyenv

ARG PYTHON_VERSION=3.6
RUN /pyenv/bin/pyenv install $PYTHON_VERSION
COPY requirements.txt .

RUN --mount=type=cache,target=/root/.cache eval "$(/pyenv/bin/pyenv init -)" && \
        /pyenv/bin/pyenv local $PYTHON_VERSION && \
        pip install --upgrade pip && \
        pip install -r requirements.txt && \
        /pyenv/bin/pyenv rehash

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /app
ENTRYPOINT ["/entrypoint.sh", "$PYTHON_VERSION"]
