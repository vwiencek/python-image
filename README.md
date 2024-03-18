docker build . -t ghcr.io/vwiencek/python-test:latest
docker push ghcr.io/vwiencek/python-test:latest
docker run -v $PWD:/app -v $PWD/report:/allure-results python-test
