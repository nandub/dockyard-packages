# vLLM

vLLM serves models through an OpenAI-compatible HTTP API. Defaults bind to `127.0.0.1:8000` and use a persistent Hugging Face cache volume.

GPU support should be added through an operator override on NVIDIA hosts.
