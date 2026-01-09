#!/bin/bash

# 1. Load variables from the copied .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
  echo "Environment variables loaded."
fi

# 2. Configure (only if not already done)
if [ ! -f .runner ]; then
    echo "Configuring GitHub Runner..."
    ./config.sh --url "${REPO_URL}" --token "${RUNNER_TOKEN}" --unattended --replace
fi

# 3. Start the runner
echo "Starting GitHub Runner..."
./run.sh