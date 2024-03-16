#!/bin/bash

eval "$(/pyenv/bin/pyenv init -)"
/pyenv/bin/pyenv local $1
python -m pytest -v --alluredir /allure-results
pip install allure-pytest

# If pytest terminated with a nonzero exit code, fail the GitHub workflow job
# using the special '::error' directive
# https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-error-message
if [ $? -ne 0 ]
then
    echo '::error::Tests failed. Refer to the "Checks" tab for details.'
fi
