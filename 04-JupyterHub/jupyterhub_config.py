import os

c = get_config()

# JupyterHub 연결 설정
c.JupyterHub.ip = "0.0.0.0"
c.JupyterHub.hub_ip = "0.0.0.0"  # listen on all interfaces
c.JupyterHub.hub_connect_ip = "jupyterhub"  # JupyterHub의 docker network상의 IP나 hostname
c.DockerSpawner.use_internal_ip = True  # docker container 내부 ip 사용
c.DockerSpawner.network_name = "jupyterhub"  # docker-compose.yml의 networks 이름

# 인증
c.Authenticator.admin_users = {"admin"}
c.LocalAuthenticator.create_system_users = True
# c.Spawner.http_timeout = 300

# DockerSpawner 설정
# DockerSpawner를 사용하여 각 사용자마다 독립적인 Jupyter Notebook 컨테이너를 생성
c.JupyterHub.spawner_class = "dockerspawner.DockerSpawner"
c.DockerSpawner.image = "kwater/deepko:hub" # 원하는 이미지명
# c.DockerSpawner.image = "teddylee777/deepko"
# c.DockerSpawner.cmd = ["start-singleuser.sh"]  # base image가 jupyter 이미지일 경우에만 사용

# 작업공간 설정
c.DockerSpawner.notebook_dir = "/data/{username}"
c.DockerSpawner.volumes = {
    "../data/{username}": {"bind": "/data/{username}", "mode": "rw"}
}

# GPU 설정
# c.DockerSpawner.extra_create_kwargs.update({"runtime": "nvidia"}) # TODO: runtime 인식을 못함, 아래 코드로 대체
import docker
c.DockerSpawner.extra_host_config = {
    "device_requests": [
        docker.types.DeviceRequest(
            count=-1,
            capabilities=[["gpu"]],
        ),
    ],
}

# 생성 정책
c.DockerSpawner.remove = True
c.DockerSpawner.start_timeout = 300  # 5min