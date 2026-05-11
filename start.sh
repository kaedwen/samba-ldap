#!/bin/bash
set -e

# Start nslcd (NSS LDAP daemon)
echo "Starting nslcd..."
/usr/sbin/nslcd
sleep 2

# Set LDAP password if provided via environment
if [ -n "$SAMBA_LDAP_PASSWORD" ]; then
    echo "Setting Samba LDAP password from environment..."
    smbpasswd -w "$SAMBA_LDAP_PASSWORD"
fi

# Start Samba services
echo "Starting Samba..."
/usr/sbin/nmbd -D

echo "Starting smbd in foreground..."
exec /usr/sbin/smbd -F --no-process-group --debug-stdout
