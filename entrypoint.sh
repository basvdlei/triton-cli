#!/bin/bash

# Ensure Triton prolile exists or create when interactive.
if [ ! -f "${HOME}/.triton/config.json" ]; then
	echo "No triton profile detected" >&2
	if [ ! -t 1 ]; then
		exit 1
	fi
	# Triton commands fail if ~/.ssh does not exist, even when using an
        # ssh-agent.
	mkdir -p "${HOME}/.ssh" >/dev/null 2>&1
	triton profile create
fi

# Make sure Docker client setup is done.
if [ ! -d "${HOME}/.triton/docker" ]; then
	echo "Triton Docker is not setup" >&2
	if [ ! -t 1 ]; then
		exit 1
	fi
	triton profile docker-setup -y
fi

eval "$(triton env)"
echo 'PS1="${SDC_ACCOUNT}@${TRITON_PROFILE} \W\\$ "' >> /root/.bashrc
exec /bin/bash "$@"
