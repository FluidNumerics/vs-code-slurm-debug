#!/bin/bash

#python3 -m debugpy --listen 10.0.0.81:5678 $1
#python $1

#/opt/apps/spack/var/spack/environments/rccs-61/.spack-env/view/bin/python 
#python3 /home/garrett/.vscode-server/extensions/ms-python.python-2023.8.0/pythonFiles/lib/python/debugpy/adapter/../../debugpy/launcher 5678 --$1

#/opt/apps/spack/var/spack/environments/rccs-61/.spack-env/view/bin/python /home/garrett/.vscode-server/extensions/ms-python.python-2023.8.0/pythonFiles/lib/python/debugpy/adapter/../../debugpy/launcher 5678 -- $1

python task_resources/debug_test.py

