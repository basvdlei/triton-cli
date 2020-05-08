FROM docker.io/library/node:12-slim
RUN apt-get update && \
	apt-get install -y curl build-essential openssh-client python && \
	rm -rf /var/lib/apt/lists/*

# Triton CLI
RUN npm install --unsafe-perm -g triton

# Triton Docker CLI
RUN curl --verbose --output /usr/local/bin/triton-docker                                   \
        https://raw.githubusercontent.com/joyent/triton-docker-cli/master/triton-docker && \
    chmod +x /usr/local/bin/triton-docker                                               && \
    ln -s /usr/local/bin/triton-docker /usr/local/bin/triton-compose                    && \
    ln -s /usr/local/bin/triton-docker /usr/local/bin/triton-docker-install             && \
    /usr/local/bin/triton-docker-install                                                && \
    ln -s /usr/local/bin/triton-docker-helper /usr/local/bin/docker                     && \
    mkdir -p /root/.ssh

# Setup entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
