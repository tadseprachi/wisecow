# Base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install required system packages: cowsay and fortune
RUN apt-get update && apt-get install -y \
    fortune \
    cowsay \
    && rm -rf /var/lib/apt/lists/*

# Copy application code
COPY . /app

# Install Python dependencies if any (if a requirements.txt exists)
RUN if [ -f "requirements.txt" ]; then \
        pip install --no-cache-dir -r requirements.txt; \
    else \
        pip install --no-cache-dir Flask flask_cors requests; \
    fi

# Make the script executable
RUN chmod +x wisecow.sh

# Expose the application port
EXPOSE 5000

# Set the entry point
CMD ["./wisecow.sh"]

