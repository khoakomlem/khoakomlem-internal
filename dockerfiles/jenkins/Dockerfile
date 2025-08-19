# Use official Jenkins LTS image
FROM jenkins/jenkins:latest

USER jenkins

# Copy plugins list
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install plugins with retry mechanism and timeout
RUN jenkins-plugin-cli \
    --plugin-file /usr/share/jenkins/ref/plugins.txt \
    --verbose || \
    # Retry with clean cache if first attempt fails
    (echo "First attempt failed, retrying with clean cache..." && \
     jenkins-plugin-cli \
     --plugin-file /usr/share/jenkins/ref/plugins.txt \
     --verbose --clean-download-directory)