FROM debian:bookworm-slim

# Install Samba, LDAP client libraries, and NSS/PAM LDAP
RUN apt-get update &&     DEBIAN_FRONTEND=noninteractive apt-get install -y     samba     samba-common-bin     libnss-ldapd     libpam-ldapd     nslcd     ldap-utils     && apt-get clean &&     rm -rf /var/lib/apt/lists/*

# Expose Samba ports
EXPOSE 445/tcp 139/tcp 137/udp 138/udp

# Start script that runs both nslcd and smbd
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD /start.sh
