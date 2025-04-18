FROM node:14-bullseye

# Install socat
RUN apt-get update && apt-get install -y socat

# Install Meteor (without hang)
RUN curl https://install.meteor.com/ | sed 's/RELEASE=".*"/RELEASE="3.1.2"/' | bash -s -- --quiet

# Allow Meteor to run as root
ENV METEOR_ALLOW_SUPERUSER=true

# Set working directory
WORKDIR /app

# Clone repo and install dependencies inside /backend
RUN git clone https://github.com/Informfully/Platform.git . && \
    cd backend && \
    meteor npm install

# Set working directory for runtime
WORKDIR /app/backend

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose app and Mongo ports
EXPOSE 3000 3909

# Use the custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]
