# ddev-deploy
Dev and deploy Image based on [DDEV Webserver Image](https://hub.docker.com/r/drud/ddev-webserver)

## Build
Build & Push
```
docker build -t bokazio/ddev-deploy-image:latest -t bokazio/ddev-deploy-image:<VERSION-TAG> .

docker push bokazio/ddev-deploy-image:latest
docker push bokazio/ddev-deploy-image:<VERSION-TAG>
```