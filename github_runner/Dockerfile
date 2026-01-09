FROM ubuntu:20.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install tools
RUN apt-get update && apt-get install -y \
    curl sudo git jq tar libicu66 docker.io

# 2. Create user
RUN useradd -m runner && \
    usermod -aG sudo runner && \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/runner

# 3. Download Runner
RUN curl -o actions-runner-linux-x64-2.311.0.tar.gz -L \
    https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz \
    && ./bin/installdependencies.sh

# 4. Copy files
COPY .env ./ 
COPY entrypoint.sh ./
RUN chmod +x ./entrypoint.sh

# --- THE FIX STARTS HERE ---
# 5. Give the 'runner' user ownership of all files
RUN chown -R runner:runner /home/runner

# 6. Ensure the runner user is in the docker group (to use the socket)
RUN usermod -aG docker runner

# 7. Switch from root to the runner user
USER runner
# ---------------------------

ENTRYPOINT ["./entrypoint.sh"]