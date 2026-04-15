# Solo Unicorn Builder - Development Container
# 
# A fully-equipped development environment with all tools needed to use
# the Solo Unicorn Builder skill set. Run everything in a container —
# no local installation required except Docker.
#
# Build:
#   docker build -t unicorn-dev .devcontainer/
#
# Run interactively:
#   docker run -it --rm -v $(pwd):/workspace unicorn-dev
#
# Or use with VS Code Dev Containers / GitHub Codespaces

FROM debian:bookworm-slim

LABEL maintainer="Solo Unicorn Builder"
LABEL description="Development container with all prerequisites for Solo Unicorn Builder"

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set up locale
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# =============================================================================
# System packages
# =============================================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Core utilities
    ca-certificates \
    curl \
    wget \
    gnupg \
    unzip \
    zip \
    jq \
    # Version control
    git \
    # Build tools
    build-essential \
    # Media processing
    ffmpeg \
    # Shell
    bash \
    bash-completion \
    # Networking
    openssh-client \
    # Editor (for quick edits)
    vim-tiny \
    && rm -rf /var/lib/apt/lists/*

# =============================================================================
# Python 3.11
# =============================================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/bin/python3 /usr/bin/python

# =============================================================================
# Node.js 20 LTS
# =============================================================================
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g npm@latest

# =============================================================================
# GitHub CLI (gh)
# =============================================================================
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/*

# =============================================================================
# Google Cloud CLI (gcloud)
# =============================================================================
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | tee /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
    && apt-get update \
    && apt-get install -y --no-install-recommends google-cloud-cli \
    && rm -rf /var/lib/apt/lists/*

# =============================================================================
# AWS CLI v2
# =============================================================================
RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "awscliv2.zip" \
    && unzip -q awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# =============================================================================
# Common Python packages (useful for skills)
# =============================================================================
RUN pip3 install --no-cache-dir --break-system-packages \
    # HTTP requests
    requests \
    httpx \
    # Data processing
    pandas \
    # Linting/formatting (for code quality)
    ruff \
    black \
    # Testing
    pytest

# =============================================================================
# Workspace setup
# =============================================================================
WORKDIR /workspace

# Create a non-root user for security
RUN useradd -m -s /bin/bash developer \
    && chown -R developer:developer /workspace

# Switch to non-root user
USER developer

# Set up Git to use the workspace safely
RUN git config --global --add safe.directory /workspace

# Default command
CMD ["/bin/bash"]
