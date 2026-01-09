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

# 3. Download the version GitHub is demanding (2.330.0)
RUN curl -o actions-runner-linux-x64-2.330.0.tar.gz -L \
    https://github.com/actions/runner/releases/download/v2.330.0/actions-runner-linux-x64-2.330.0.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.330.0.tar.gz \
    && ./bin/installdependencies.sh

# 4. Copy files (Method 2)
COPY .env ./ 
COPY entrypoint.sh ./
RUN chmod +x ./entrypoint.sh

# 5. Give the 'runner' user ownership of all files
RUN chown -R runner:runner /home/runner

# --- THE FIX FOR GID 120 ---
# 6. Change the container's docker group to match the host (120)
# We use '|| true' just in case group 120 is already taken, preventing a build crash
RUN groupmod -g 120 docker || true

# 7. Add runner to this updated group
RUN usermod -aG docker runner
# ---------------------------

# 8. Switch from root to the runner user
USER runner

ENTRYPOINT ["./entrypoint.sh"]