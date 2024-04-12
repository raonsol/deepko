FROM teddylee777/deepko
RUN pip3 install \
    jupyterhub \
    notebook

# create a user, since we don't want to run as root
RUN useradd -m jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME
USER jovyan