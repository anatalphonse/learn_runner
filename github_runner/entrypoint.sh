#!/bin/bash

# 1. Load the variables from the physical .env file
if [ -f .env ]; then
    export $(cat .env | xargs)
    echo "Environment variables loaded from .env file"
fi

# 2. Configure the runner using the loaded variables
if [ ! -f .runner ]; then
    ./config.sh --url ${REPO_URL} --token ${RUNNER_TOKEN} --unattended --replace
fi

# 3. Start the runner
./run.sh