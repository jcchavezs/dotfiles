# layer0
alias l0='layer0'

export KUBECONFIG="$KUBECONFIG:$HOME/.kube/layer0-dev"

export PATH=$PATH:$HOME/.local/bin
export EDITOR=code

eval "$(direnv hook zsh)"
autoload bashcompinit && bashcompinit
