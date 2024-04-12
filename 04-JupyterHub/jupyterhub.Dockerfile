FROM jupyterhub/jupyterhub

# 패키지 설치
RUN apt-get update && apt-get install -y python3-pip
RUN python3 -m pip install --no-cache-dir \
    dockerspawner \
    jupyterhub-nativeauthenticator \
    notebook \
    jupyterlab

# config 복사
COPY jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py
CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]

EXPOSE 8000