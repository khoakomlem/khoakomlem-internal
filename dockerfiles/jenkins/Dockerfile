# Use official Jenkins LTS image
FROM jenkins/jenkins:lts

# Switch to root to install dependencies
USER root

# Install Docker CLI and other dependencies
RUN apt-get update && \
  apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  sudo && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  apt-get update && \
  apt-get install -y docker-ce-cli && \
  rm -rf /var/lib/apt/lists/*

# Add jenkins user to docker group (if it exists) and sudo group
RUN usermod -aG docker jenkins || true && \
  usermod -aG sudo jenkins && \
  echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch back to jenkins user
USER jenkins

# Set environment variables for plugin installation
ENV JENKINS_UC_DOWNLOAD https://updates.jenkins.io/download
ENV JENKINS_UC https://updates.jenkins.io
ENV JENKINS_INCREMENTALS_REPO_MIRROR https://repo.jenkins-ci.org/incrementals

# Copy plugins list
COPY plugins.txt /usr/share/jenkins/plugins.txt

# Install plugins with retry mechanism and timeout
RUN jenkins-plugin-cli \
  --plugin-download-directory /usr/share/jenkins/ref/plugins \
  --plugin-file /usr/share/jenkins/plugins.txt \
  --latest false \
  --verbose || \
  # Retry with different mirror if first attempt fails
  (echo "Retrying with default mirror..." && \
  jenkins-plugin-cli \
  --plugin-download-directory /usr/share/jenkins/ref/plugins \
  --plugin-file /usr/share/jenkins/plugins.txt \
  --latest false \
  --verbose)

# Expose ports
EXPOSE 8080 50000