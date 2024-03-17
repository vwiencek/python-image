#!/bin/bash

eval "$(/pyenv/bin/pyenv init -)" && /pyenv/bin/pyenv local $PYTHON_VERSION
python -m pytest --tb=long --showlocals -v --alluredir /allure-results

if [ $? -ne 0 ]
then
    echo '::error::Tests failed. Refer to the "Checks" tab for details.'
fi
