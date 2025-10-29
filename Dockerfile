FROM debian:bookworm-slim

# Instala dependências básicas
RUN apt-get update && apt-get install -y curl bash ca-certificates && rm -rf /var/lib/apt/lists/*

# Instala OPA versão estática (sem dependência de glibc)
RUN curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64_static && \
    chmod +x opa && mv opa /usr/local/bin/opa

# Instala Conftest
RUN CONFTAG=$(curl -s https://api.github.com/repos/open-policy-agent/conftest/releases/latest | grep tag_name | cut -d '"' -f 4) && \
    echo "Baixando Conftest versão $CONFTAG" && \
    curl -L -o conftest https://github.com/open-policy-agent/conftest/releases/download/$CONFTAG/conftest_Linux_x86_64 && \
    chmod +x conftest && mv conftest /usr/local/bin/conftest

WORKDIR /workspace
CMD ["/bin/bash"]
