FROM python:3.10-slim

# Install Git
RUN apt-get update && apt-get install -y git && apt-get clean

# Copy files
COPY webhook_listener.py .
COPY update_repo.sh .

# Make the script executable
RUN chmod +x update_repo.sh

# Expose port
EXPOSE 8000

# Set default environment variables (can be overridden later)
ENV REPO_DIR=helm
ENV REPO_URL=https://github.com/gAhmedg/helm.git

# Run the Python script when the container starts
CMD ["python", "webhook_listener.py"]
