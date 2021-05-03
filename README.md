# dev-storage
Docker image for the storage layer of my development environment

## Build

```
docker build -t dev-storage .
```

## Run
```
docker run --rm -it --name dev-storage --privileged --mount source=my-dev-storage,target=/root -p 2200:22 dev-storage zsh
```

To copy the starter dotfiles, do:

```
docker cp starter-dotfiles/. dev-storage:/root
```
## Release

```
make release version=(patch|minor|major)
```

This will read the current version from `version.txt`, bump it accordingly, and:
- store it back to `version.txt`,
- update `deploy/k8s.yaml`,
- build the new container with the correct tag,
- push the container to the registry


