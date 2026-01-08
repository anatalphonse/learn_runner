FROM ubuntu:20.04

# Avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl sudo git jq build-essential libssl-dev libffi-dev python3 python3-venv \
    docker.io

# Create a runner user
RUN useradd -m runner

# Download the GitHub Actions Runner (Update version as needed)
WORKDIR /home/runner
RUN curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz \
    && tar xzf ./actions-runner-linux-x64.tar.gz

# Install dependencies required by the runner
RUN ./bin/installdependencies.sh

USER runner
COPY entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]