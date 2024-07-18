FROM teddylee777/deepko
RUN pip3 install --upgrade \
    jupyterhub \
    notebook \
    jupyterlab \
    py-cpuinfo \
    openpyxl \
    comet_ml
RUN pip3 install --upgrade \
    jupyterlab_execute_time \
    jupyterlab-code-formatter \
    black \
    isort \
    jupyterlab-notifications \
    jupyterlab_nvdashboard \
    jupyterlab-lsp \
    'python-lsp-server[all]' \
    jupyter-resource-usage \
    jupyter-tensorboard-proxy
# create a user, since we don't want to run as root
RUN useradd -m jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME
USER jovyan

# unsupported locale setting error 해결
ENV LC_ALL=C

CMD ["jupyterhub-singleuser", "--ResourceUseDisplay.track_cpu_percent=True"]