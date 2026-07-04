# Security notes

n8n can store credentials and run automation workflows that call external systems. Keep it on loopback or behind a TLS reverse proxy with authentication. Set a unique `app.encryptionKey` before first use; changing it later can make stored credentials unreadable.
