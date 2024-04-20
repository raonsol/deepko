FROM teddylee777/deepko
RUN pip3 install --upgrade \
    jupyterhub \
    notebook \
    jupyterlab \
    py-cpuinfo

# create a user, since we don't want to run as root
RUN useradd -m jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME
USER jovyan

CMD ["jupyterhub-singleuser", "--ResourceUseDisplay.track_cpu_percent=True"]