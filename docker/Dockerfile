# Dockerfile
FROM debian:slim

# Set environment variables
ENV URL_DNS_LIST_CUSTOM=""
ENV MAZA_DIR="/etc/maza"
ENV MAZA_SCRIPT="/usr/local/bin/maza"

# Install dependencies
RUN apt-get update && apt-get install -y \
    dnsmasq \
    curl \
    bash \
    cron \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add the maza script
COPY maza $MAZA_SCRIPT
RUN chmod +x $MAZA_SCRIPT

# Configure dnsmasq
RUN mkdir -p "$MAZA_DIR" \
    && echo "conf-file=$MAZA_DIR/dnsmasq.conf" >> /etc/dnsmasq.conf

# Configure cron to update the maza list daily
RUN echo "@daily $MAZA_SCRIPT update" >> /etc/cron.d/maza-cron \
    && chmod 0644 /etc/cron.d/maza-cron \
    && crontab /etc/cron.d/maza-cron

# Expose necessary ports
EXPOSE 53/udp 53/tcp 67/udp

# Start dnsmasq and cron
CMD service cron start && dnsmasq -k
