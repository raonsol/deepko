FROM teddylee777/deepko
RUN pip3 install --upgrade \
    jupyterhub \
    notebook \
    jupyterlab \
    py-cpuinfo \
    openpyxl

# create a user, since we don't want to run as root
RUN useradd -m jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME
USER jovyan

# unsupported locale setting error 해결
ENV LC_ALL=C

CMD ["jupyterhub-singleuser", "--ResourceUseDisplay.track_cpu_percent=True"]