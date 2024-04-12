# JupyterHub로 배포하기

## Build client image

```bash
cd 04-JupyterHub
docker build -t kwater/deepko:hub -f jupyterhub_client.Dockerfile .
```

## Deploy host image (jupyterhub)

폴더 최상단 경로에서 실행

```bash
docker-compose up -d --build jupyterhub
```
