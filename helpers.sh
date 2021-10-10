GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CLOSE='\033[0m'
CYAN='\033[0;36m'

read_var() {
    VAR=$(grep "^$1" "$2" | xargs)
    IFS="=" read -ra VAR <<<"$VAR"
    echo "${VAR[1]}"
}

log(){
    echo -e "${CYAN}[$(date "+%Y-%m-%d %H:%M:%S")] $1"
}

create_secret(){
  if [[ $(docker secret ls | grep "$1") = "" ]]; then
      log "${GREEN} Creating $1 secret ${CLOSE}"
      echo "$2" | docker secret create "$1" -
  else
        log "${YELLOW} $1 secret already exists ${CLOSE}"
  fi
}