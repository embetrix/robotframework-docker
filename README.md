# Docker Image for Robot-Framework

Docker Image with Ubuntu 20.04 Bionic and all dependencies to work with robotframework

## Generate Docker Image

Enable docker multiarch support:

```
docker buildx create --name multiarch --use
```

Install Cross-platform emulator collection:

```
docker run -it --rm --privileged tonistiigi/binfmt --install all
```

Build multiarch image and push it to registry:

```
docker buildx build --push --platform linux/arm64,linux/amd64 --rm=true --tag embetrix/robotframework:latest .
```      
## Run Docker Image

```
docker run --rm -ti -h robotframework  embetrix/robotframework:latest
```