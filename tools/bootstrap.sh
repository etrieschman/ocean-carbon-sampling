#!/bin/bash
. $(dirname $0)/script_setup.sh

echo "BOOTSTRAPPING PYTHON ENVIRONMENT"

installed_version=$(pyenv versions | grep "$PYTHON_VER")

  # TODO ask Devops about the python SSL missing if python is not reinstalled from scratch
  echo "Installing Python version '$PYTHON_VER'..."
  pyenv install $PYTHON_VER

  [ $? -ne 0 ] && echo "ERROR: Unable to install required python version" && exit 1

virtual_env=$(pyenv versions | grep "$VIRTUAL_PY")
case "$virtual_env" in
  *$VIRTUAL_PY*) 
  echo "Python virtual env '$VIRTUAL_PY' is already created"
  ;;   # the PYTHON_VER is already installed - nothing to do
  *)
    echo "Python virtual env '$VIRTUAL_PY' is not created - creating now..."
    pyenv virtualenv $PYTHON_VER $VIRTUAL_PY

    [ $? -ne 0 ] && echo "ERROR: Unable to create python virtual env" && exit 1
  ;;
esac

echo "Setting local python virtual env"

pyenv local $VIRTUAL_PY

echo "INSTALL DEPENDENCIES"

pip install -r requirements.txt

yarn install
