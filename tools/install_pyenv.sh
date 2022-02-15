prompt="Choose a terminal settings file for initializing pyenv"
options=(".bash_profile" ".bash_rc" ".zprofile" ".zshrc")

echo "Choose a terminal settings file for initializing pyenv"
PS3=""
select opt in "${options[@]}"; do 

    case "$REPLY" in

    1 ) SETTINGS_FILE=$opt;break;;
    2 ) SETTINGS_FILE=$opt;break;;
    3 ) SETTINGS_FILE=$opt;break;;
    4 ) SETTINGS_FILE=$opt;break;;
    *) echo "Invalid option. Try another one.";continue;;

    esac

done

echo "Using $SETTINGS_FILE as settings file"

if [ ! -d ~/.pyenv ]; then
  echo "Installing pyenv..."
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
else
  echo "pyenv already installed"
fi

if [ ! -d ~/.pyenv/plugins/pyenv-virtualenv ]; then
  echo "Installing pyenv-virtualenv..."
  git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
else
  echo "pyenv-virtualenv already installed"
fi 

if grep -q pyenv ~/$SETTINGS_FILE; then
  echo "pyenv already appears in $SETTINGS_FILE"
else
  echo "Appending $SETTINGS_FILE to include pyenv shim"
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/$SETTINGS_FILE
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/$SETTINGS_FILE
  echo 'if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi' >> ~/$SETTINGS_FILE
  echo 'if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi' >> ~/$SETTINGS_FILE
fi

echo "Done installing, make sure to run 'source ~/$SETTINGS_FILE'"
