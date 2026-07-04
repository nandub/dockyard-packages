# Security notes

AnythingLLM may store uploaded documents, embeddings metadata, prompts, and provider credentials. Keep it on loopback or behind a TLS reverse proxy with authentication. Do not commit provider API keys in values files.
