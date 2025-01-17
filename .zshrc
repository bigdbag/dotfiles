alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

alias cdw='cd $WINDOWS_HOME'

alias cds='cd $HOME/Source'

export ADOTDIR=$HOME/.zsh/bundle

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export WINDOWS_HOME=/mnt/c/Users/shake

#export JAVA_HOME=$(/usr/libexec/java_home)

#export JAVA_HOME=/usr/lib/jvm/java-16-oracle

export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/mysql/lib

export PYENV_ROOT=$HOME/.pyenv

export RBENV_ROOT=$HOME/.rbenv

#export JENV_ROOT=$HOME/.jenv

export PYTHONPATH='.'

#PATH

export PATH=$PATH:$JAVA_HOME/bin

export PATH=$PATH:$PYENV_ROOT/bin

export PATH=$PATH:$RBENV_ROOT/bin

export PATH=$PATH:$JENV_ROOT/bin

export PATH=$PATH:$HOME/bin

export PATH=$PATH:$HOME/.local/bin

export PATH=$PATH:/usr/local/opt/openssl/bin

export PATH=$PATH:/usr/local/bin

export PATH=$PATH:/usr/local/mysql/bin

export PATH=$PATH:/usr/local/go/bin

export PATH=$PATH:/mnt/c/Program\ Files/Docker/Docker/resources/bin
export PATH="$PATH:$(yarn global bin)"
#eval "$(rbenv init -)"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
#eval "$(jenv init -)"

source $HOME/.zsh/bundle/bin/antigen.zsh

antigen use oh-my-zsh # Load the oh-my-zsh's library.
antigen bundle git

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme agnoster # Load the theme.
antigen apply # Tell antigen that you're done.
