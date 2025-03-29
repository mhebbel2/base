#!/bin/bash

FILE=Anaconda3-2024.02-1-Linux-x86_64.sh
wget https://repo.anaconda.com/archive/$FILE

chmod +x $FILE

./$FILE -b -p $HOME/.anaconda3

rm $FILE 

CONDA=$HOME/.anaconda3/bin/conda
$CONDA config --set auto_activate_base false
$CONDA init bash
$CONDA install -y argcomplete
# $CONDA create -y -n myenv  jupyter jupyterlab matplotlib numpy ipykernel

echo 'export PATH=$HOME/.anaconda3/bin:$PATH' >> $HOME/.bashrc
echo 'eval "$(register-python-argcomplete conda)"' >> $HOME/.bashrc

# python3 -m ipykernel install --user --name=myenv
