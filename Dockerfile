FROM debian:stable-slim
USER root
# Install SSH & websockify
RUN apt-get update && \
    apt-get install -y openssh-server python3-websockify && \
    mkdir -p /var/run/sshd

# Buat user login
RUN useradd -m -s /bin/bash user && echo "user:user" | chpasswd

# Expose port
EXPOSE 2222 8080

# Jalankan SSH + WebSocket
CMD service ssh start && \
    websockify 0.0.0.0:8080 localhost:22 --daemon && \
    tail -f /dev/null
