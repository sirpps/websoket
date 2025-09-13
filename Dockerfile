FROM solsson/websocat:latest

# Install openssh-server
RUN apk add --no-cache openssh-server bash

# Buat user SSH
RUN adduser -D user && echo "user:user" | chpasswd

# Jalankan sshd di port 2222
RUN mkdir -p /var/run/sshd
EXPOSE 2222 8080

# Entrypoint: jalanin sshd + websocat
CMD /usr/sbin/sshd -D -p 2222 & \
    websocat --binary ws-l:0.0.0.0:8080 tcp:127.0.0.1:2222
