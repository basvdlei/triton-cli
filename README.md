Triton CLI Container
====================

Container image containing the Triton/Docker CLI tools.

Build
-----

```
podman build -t localhost/triton-cli:latest .
```

Usage
-----

```
# Load your Triton SSH key
ssh-add triton-key

# Create a profile directory.
mkdir -p "${HOME}/.config/triton"

# Run the container interactive to create a profile
podman run --rm -it --security-opt=label=disable \
	-e "SSH_AUTH_SOCK=${SSH_AUTH_SOCK}" \
	-v "${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK}" \
	-v "${HOME}/.config/triton:/root/.triton" \
	localhost/triton-cli:latest
```

**Note**: All this can be done with non-root podman. The
`--security-opt=label=disable` is required when SELinux enabled.
