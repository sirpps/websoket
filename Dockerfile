FROM solsson/websocat:latest

# Install openssh-server
USER root
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    echo "user:user" | chpasswd

# Buat user "user"
RUN useradd -m user

# Expose port
EXPOSE 2222 8080

# Start sshd di 2222 + bridge WebSocket 8080 -> 2222
CMD /usr/sbin/sshd -D -p 2222 & \
    websocat --binary ws-l:0.0.0.0:8080 tcp:127.0.0.1:2222
