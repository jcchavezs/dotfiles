function github_open() {
  if [[ ! -d .git ]]; then
    echo "$(pwd) is not a git folder."
    return 1
  fi
  REPOSITORY_URL=$(git remote -v | awk '/origin.+fetch/{print $2}' | cut -f2 -d@ | sed -e s/:/\\//)
  open https://${REPOSITORY_URL}
}

# Undoes the last commit, includes the staged files and redoes the commit.
function git_ammend_last_commit() {
  message=`git log -1 --pretty=%B`
  git --no-pager diff --name-only --staged --exit-code
  if [[ $? == "0" ]]; then
    # if there are not staged changes we can't continue
    echo "Stage your new changes first!"
    return 1
  fi
  git reset HEAD~1 --soft
  git commit -m "$message"
}

# List all added/modified files that are not deleted matching a regex name and a word
# Usage: gmf [filename_pattern [search_word]]
# E.g. : gmf '.kt' avro
function git_modified_files() {
  if [[ $# -gt 2 ]]; then
    echo "Too many arguments, did you pass .* as first argument? pass '.*' instead."
    return 1
  fi
  if [[ $1 == "" || $1 == ".*" ]]; then
    if [[ $2 == "" ]]; then
      # list files | filter in those that are added or modified but not deleted
      git status -s -u | awk '{if ((($1 ~ "M" || $1 ~ "A") && $1 !~ "D") || $1 == "??") print $2}'
    else
      # list files | filter in those that are added or modified but not deleted | filter by extension
      git status -s -u | awk '{if ((($1 ~ "M" || $1 ~ "A") && $1 !~ "D") || $1 == "??") print $2}' | xargs grep -l -w "$2"
    fi
  else
    if [[ $2 == "" ]]; then
      # list files | filter in those that are added or modified but not deleted | filter by extension | remove the bullets
      git status -s -u | awk '{if ((($1 ~ "M" || $1 ~ "A") && $1 !~ "D") || $1 == "??") print $2}' | grep -n "$1" | awk -F: '{print $2}'
    else
      # list files | filter in those that are added or modified but not deleted | filter by extension | remove the bullets | filter by text 
      git status -s -u | awk '{if ((($1 ~ "M" || $1 ~ "A") && $1 !~ "D") || $1 == "??") print $2}' | grep -n "$1" | awk -F: '{print $2}' | xargs grep -l -w "$2"
    fi
  fi  
}

# Creates a branch and adds a wip commit with all modified/added files.
function git_branch_wip() {
  if [[ "$1" == "" ]]; then
    echo "First argument (branch name) is required."
    return 1
  fi

  current_branch=`git symbolic-ref HEAD | cut -d"/" -f 3,4`;
  gco -b $1
  git add .
  git commit -m "wip" --no-verify
  gco $current_branch
}

function kube_use_namespace() {
  kubectl config set-context --current --namespace=$1
  current_namespace=$(kube_get_current_namespace)
  echo "Current namespace: $current_namespace"
}

function kube_get_current_namespace() {
  kubectl config view --minify | grep namespace: | awk '{print $2}'
}

function kube_reset_namespace() {
  kubectl config set-context --current --namespace=kube-system
}

function kube_list_pods() {
  NAMESPACE_ARGS=""
  if [[ ! "$1" == "" ]]; then
    NAMESPACE_ARGS="-n $1"
  fi

  CMD="kubectl get pods $NAMESPACE_ARGS"
  sh -c "$CMD"
}

# list the running pods for a given app (optionally in a namespace)
function kube_get_pods() {
  NAMESPACE_ARGS=""
  if [[ "$#" == "2" ]]; then
    NAMESPACE_ARGS="-n $2"
  fi

  CMD="kubectl get pods $NAMESPACE_ARGS"
  if [[ ! "$1" == "" ]]; then
    CMD="$CMD --selector=app=$1"
  fi
  sh -c "$CMD"
}

# list the running pod images for a given app (optionally in a namespace)
function kube_get_app_images() {
  if [[ "$1" == "" ]]; then
    echo "First agument (app label) is required."
    return 1
  fi

  NAMESPACE_ARGS=""
  if [[ "$#" == "2" ]]; then
    NAMESPACE_ARGS="-n $2"
  fi

  sh -c "kubectl get pod -o json --selector=app=$1 $NAMESPACE_ARGS"  | jq '.items' | jq -c '.[].spec.containers' | jq -r -c '.[].image' | grep $1
}

function kube_get_pod_image() {
  if [[ "$1" == "" ]]; then
    echo "First agument (pod name) is required."
    return 1
  fi

  NAMESPACE_ARGS=""
  if [[ "$#" == "2" ]]; then
    NAMESPACE_ARGS="-n $2"
  fi

  sh -c "kubectl get pod -o json $1 $NAMESPACE_ARGS"  | jq -c '.spec.containers' | jq -r -c '.[].image'
}

function kube_describe_pod() {
  NAMESPACE_ARGS=""
  if [[ "$#" == "2" ]]; then
    NAMESPACE_ARGS="-n $2"
  fi

  sh -c "kubectl describe pod $1 $NAMESPACE_ARGS"
}

function kube_logs() {
  CMD="kubectl logs"
  if [[ "$1" == "-f" ]]; then
    CMD="$CMD -f"
    shift
  fi

  if [[ "$1" == "" ]]; then
    echo "First agument (pod name) is required."
    return 1
  fi

  NAMESPACE_ARGS=""
  if [[ "$#" == "2" ]]; then
    NAMESPACE_ARGS="-n $2"
  fi

  CONTAINER_ARGS=""
  if [[ "$#" == "3" ]]; then
    CONTAINER_ARGS="-c $3"
  fi

  sh -c "$CMD $1 $NAMESPACE_ARGS $CONTAINER_ARGS"
}

function kube_exec() {
  CMD="/bin/sh"
  if [[ ! "$2" == "" ]]; then
     CMD="$2"
  fi
  kubectl exec -it $1 -- $CMD
}