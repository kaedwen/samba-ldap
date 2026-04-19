#!/bin/bash
set -e

# Start nslcd (NSS LDAP daemon)
echo Starting nslcd...
/usr/sbin/nslcd

# Wait a moment for nslcd to initialize
sleep 2

# Start Samba services
echo Starting Samba...
/usr/sbin/nmbd -D
/usr/sbin/smbd -F --no-process-group
