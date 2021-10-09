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
