#!/bin/bash

# Update system
apt update -y && apt upgrade -y

# Install Docker
apt install -y docker.io docker-compose nginx certbot python3-certbot-nginx

# Enable Docker
systemctl start docker
systemctl enable docker

# Login
cd /home/ubuntu

# Pull code from GitHub (OPTIONAL if using private repo deployment)
# git clone https://github.com/your-org/hubspot-service.git
# cd hubspot-service

# Docker Run
docker run -d --name ${service_name} -p ${docker_port}:8000 \
  -e AWS_REGION=eu-west-2 \
  -e ENV=prod \
  yourdockerhubuser/hubspot-service:latest

# Setup NGINX Reverse Proxy
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name ${domain_name};

    location / {
        proxy_pass http://localhost:${docker_port};
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

systemctl reload nginx

%{ if enable_https }
# Enable HTTPS using Let's Encrypt
certbot --nginx -d ${domain_name} --non-interactive --agree-tos -m admin@${domain_name}
%{ endif }