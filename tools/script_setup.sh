
#!/bin/bash
[ ! -z $DEBUG ] && set -x


CWD=$(pwd)
cd $(dirname $0)/..
REPO_ROOT=$(pwd)
echo REPO_ROOT
cd $CWD

TOOLS_DIR=$REPO_ROOT/tools
PYTHON_VER=3.9.5
VIRTUAL_PY=$(cat $REPO_ROOT/.python-version)
