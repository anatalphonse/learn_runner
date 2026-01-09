FROM ubuntu:20.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install necessary tools and Docker CLI
RUN apt-get update && apt-get install -y \
    curl sudo git jq tar libicu66 docker.io

# 2. Create a user for the runner
RUN useradd -m runner && \
    usermod -aG sudo runner && \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/runner

# 3. Download the GitHub Runner package
RUN curl -o actions-runner-linux-x64-2.311.0.tar.gz -L \
    https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz \
    && ./bin/installdependencies.sh

# --- METHOD 2 SPECIFIC STEPS ---
# 4. Copy the .env file and the startup script
# Ensure your .env file is in the 'github_runner' folder before building
COPY .env ./ 
COPY entrypoint.sh ./
RUN chmod +x ./entrypoint.sh
# -------------------------------

RUN usermod -aG docker runner
ENTRYPOINT ["./entrypoint.sh"]