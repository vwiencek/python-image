docker build . -t ghcr.io/vwiencek/python-test:latest
docker push ghcr.io/vwiencek/python-test:latest
docker run -v $PWD:/app -v $PWD/report:/allure-results -it ghcr.io/vwiencek/python-test:latest

docker run -v .:/app -v ./report:/allure-results -it ghcr.io/vwiencek/python-test:latest

eval "$(/pyenv/bin/pyenv init -)" && /pyenv/bin/pyenv local 3.7