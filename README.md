# Samba with LDAP Authentication

Debian-based Samba server with NSS/PAM LDAP integration for user authentication against OpenLDAP.

## Features

- Samba 4.x on Debian Bookworm
- NSS/PAM LDAP integration via nslcd
- ldapsam passdb backend
- SMB3 protocol
- No SMB1 (security)

## Configuration

Mount the following configuration files:

- `/etc/samba/smb.conf` - Samba configuration
- `/etc/nslcd.conf` - LDAP NSS daemon configuration  
- `/etc/nsswitch.conf` - Name service switch configuration

## Environment Variables

- `SAMBA_LDAP_PASSWORD` - LDAP bind password (via secret)

## Volumes

- `/storage` - File storage root
- `/var/lib/samba/private` - Samba secrets and database

## Ports

- `445/tcp` - SMB over TCP
- `139/tcp` - NetBIOS Session Service
- `137/udp` - NetBIOS Name Service
- `138/udp` - NetBIOS Datagram Service

## Usage

```bash
podman run -d \
  --name samba-server \
  --network openldap \
  -v ./smb.conf:/etc/samba/smb.conf:ro \
  -v ./nslcd.conf:/etc/nslcd.conf:ro \
  -v ./nsswitch.conf:/etc/nsswitch.conf:ro \
  -v /storage:/storage:rw \
  -p 445:445/tcp \
  -p 139:139/tcp \
  -p 137:137/udp \
  -p 138:138/udp \
  ghcr.io/USERNAME/samba-ldap:latest
```

## Building

```bash
podman build -t samba-ldap:latest .
```
