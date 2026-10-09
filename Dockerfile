# syntax=docker/dockerfile:1.7

ARG GO_VERSION=1.26
ARG DOCKER_VERSION=27-cli

FROM golang:${GO_VERSION}-alpine AS golang

FROM docker:${DOCKER_VERSION}

ARG TARGETARCH
ARG KIND_VERSION=v0.30.0
ARG KUBECTL_VERSION=v1.33.0

COPY --from=golang /usr/local/go /usr/local/go

ENV PATH="/usr/local/go/bin:${PATH}" \
    CGO_ENABLED=0

RUN apk add --no-cache \
      bash \
      ca-certificates \
      curl \
      git \
      make \
      openssh-client \
    && curl -fsSLo /usr/local/bin/kind \
      "https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-${TARGETARCH}" \
    && curl -fsSLo /usr/local/bin/kubectl \
      "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl" \
    && chmod +x /usr/local/bin/kind /usr/local/bin/kubectl \
    && go version \
    && docker --version \
    && kind version \
    && kubectl version --client

WORKDIR /workspace

CMD ["bash"]
