FROM node:slim
# Copy the rest of the application files

FROM mcr.microsoft.com/playwright:v1.42.1-jammy


# Set working directory
WORKDIR /app

# Copy test code
COPY . .
COPY package*.json ./
# Install dependencies
RUN npm cache clean --force
RUN npm install -g playwright
RUN npm install
RUN apt-get update && apt-get install -y wget gnupg ca-certificates && \
   curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
   apt install -y nodejs

USER 0

RUN mkdir -p /app/test-results

RUN chgrp -R 0 /app/test-results && \
    chmod -R g=u /app/test-results \
