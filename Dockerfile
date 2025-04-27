FROM nginx:latest
EXPOSE 8080
WORKDIR /app
USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.json ./
COPY entrypoint.sh ./

RUN apt-get update && apt-get install -y wget unzip iproute2 systemctl && \
    wget -O temp.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
	wget -O argo https://github.com/cloudflare/cloudflared/releases/download/2025.4.0/cloudflared-linux-amd64 && \
    unzip temp.zip xray && \
    rm -f temp.zip && \
    chmod +x xray argo entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
