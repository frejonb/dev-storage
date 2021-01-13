# dev-storage
Docker image for the storage layer of my development environment

## Build

```
docker build -t dev-storage .
```

## Run
```
docker run --rm -it --name dev-storage --mount source=my-dev-storage,target=/root -p 2200:22 dev-storage zsh
```

To copy the starter dotfiles, do:

```
docker cp starter-dotfiles/. dev-storage:/root
```