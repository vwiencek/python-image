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
        git dos2unix

ENV PYENV_ROOT /pyenv
RUN git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT

ARG PYTHON_VERSION=3.7
ENV PYTHON_VERSION=$PYTHON_VERSION

RUN /pyenv/bin/pyenv install $PYTHON_VERSION
COPY requirements.txt .

RUN --mount=type=cache,target=/root/.cache eval "$(/pyenv/bin/pyenv init -)" && \
        /pyenv/bin/pyenv local $PYTHON_VERSION && \
        pip install --upgrade pip && \
        pip install -r requirements.txt && \
        /pyenv/bin/pyenv rehash

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN dos2unix /entrypoint.sh

WORKDIR /app
#ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
