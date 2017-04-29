FROM andrewosh/binder-python-3.5-mini:latest

MAINTAINER Nezar Abdennur <nabdennur@gmail.com>

USER root

USER main

# See https://github.com/aadm/avo_explorer/blob/master/Dockerfile
# Copy from the Dockerfile generated by binder to create and activate the conda environment
ADD environment.yml environment.yml
RUN conda env create -n binder
RUN echo "export PATH=/home/main/anaconda2/envs/binder/bin/:/home/main/anaconda3/envs/binder/bin/:$PATH" >> ~/.binder_start
RUN conda install -n binder jupyter
RUN /bin/bash -c "source activate binder && jupyter kernelspec install-self --user"

# To get around the new default authentication in Jupyter
RUN mkdir $HOME/.jupyter
RUN echo "c.NotebookApp.token = ''" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password=''" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.iopub_data_rate_limit=1e22" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password_required=False" >> $HOME/.jupyter/jupyter_notebook_config.py
