
#!/bin/bash
. $(dirname $0)/script_setup.sh

pyenv uninstall $VIRTUAL_PY
[ -e $REPO_ROOT/.python-version ] && rm $REPO_ROOT/.python-version
find $TOOLS_DIR/.. -name '*.egg-info' -exec rm -r {} 2>/dev/null \;
find $TOOLS_DIR/.. -name '__pycache__' -exec rm -r {} 2>/dev/null \;
cd $CWD