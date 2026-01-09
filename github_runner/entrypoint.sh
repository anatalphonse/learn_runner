#!/bin/bash

# Load the variables from the physical .env file into the shell environment
if [ -f .env ]; then
    export $(cat .env | xargs)
    echo "Environment variables loaded."
fi

# Use the variables to configure the runner
# Only run config if the .runner file doesn't exist (prevents errors on restart)
if [ ! -f .runner ]; then
    ./config.sh --url ${REPO_URL} --token ${RUNNER_TOKEN} --unattended --replace
fi

./run.sh