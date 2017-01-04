declare -a _bash_utils_core_dependencies

bash_utils_core::require() {
  local file="$1"

  if [ ! -f "$file" ]; then
    return 1
  fi

  if ! _bash_utils_core_isRegistered "$file"; then
    _bash_utils_core_registerDependency "$file"
  fi
}

_bash_utils_core_registerDependency() {
  local file="$1"

  _bash_utils_core_dependencies+=("$file")
  source "$file"
}

_bash_utils_core_isRegistered() {
  local file="$1"

  for dependency in "${_bash_utils_core_dependencies[@]:-}"
  do
    if [[ "$dependency" == "$file" ]]
    then
      return 0
    fi
  done

  return 1;
}
