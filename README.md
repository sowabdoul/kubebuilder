# Kubebuilder

Docker image containing Go, Docker CLI, Kind and kubectl for Kubebuilder CI pipelines.

## Build the image

The default image name and version are defined in the `Makefile`:

```text
IMAGE=your-dockerhub-user/kubebuilder
VERSION=dev
```

Build the image with the default values:

```bash
make build
```

Build the image with a custom name and version:

```bash
make build \
  IMAGE=abdoulsow/kubebuilder \
  VERSION=go1.26-kind0.30-kubectl1.33
```

## Test the image

Run the tool version checks:

```bash
make test
```

The command verifies:

```text
Go
Docker CLI
Kind
kubectl
Make
```

Test a specific image:

```bash
make test \
  IMAGE=abdoulsow/kubebuilder \
  VERSION=go1.26-kind0.30-kubectl1.33
```

## Log in to Docker Hub

```bash
make login
```

## Build, test and push

The `push` target automatically:

1. builds the image;
2. tests the installed tools;
3. pushes the image.

```bash
make push \
  IMAGE=abdoulsow/kubebuilder \
  VERSION=go1.26-kind0.30-kubectl1.33
```

Published image:

```text
abdoulsow/kubebuilder:go1.26-kind0.30-kubectl1.33
```

## Build and push a multi-architecture image

The default platforms are:

```text
linux/amd64
linux/arm64
```

Build and push the multi-architecture image:

```bash
make multiarch \
  IMAGE=abdoulsow/kubebuilder \
  VERSION=go1.26-kind0.30-kubectl1.33
```

Use custom platforms if needed:

```bash
make multiarch \
  IMAGE=abdoulsow/kubebuilder \
  VERSION=go1.26-kind0.30-kubectl1.33 \
  PLATFORMS=linux/amd64
```
