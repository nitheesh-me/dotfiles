#!/bin/bash

# -e: exit on error
# -u: exit on undefined variable
set -eu

log_color() {
  color_code="$1"
  shift
  printf "\033[${color_code}m%s\033[0m\n" "$*" >&2
}

log_red() {
  log_color "0;31" "$@"
}

log_green() {
  log_color "0;32" "$@"
}

log_yellow() {
  log_color "0;33" "$@"
}

log_blue() {
  log_color "0;34" "$@"
}

log_magenta() {
  log_color "0;35" "$@"
}

log_cyan() {
  log_color "0;36" "$@"
}

log_white() {
  log_color "0;37" "$@"
}

log_task() {
  log_white "ℹ️" "$@"
}

log_success() {
  log_green "✅" "$@"
}

log_warning() {
  log_yellow "⚠️" "$@"
}

log_error() {
  log_red "❌" "$@"
}

error() {
  log_error "$@"
  exit 1
}

sudo() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    if ! command sudo --non-intractive true 2>/dev/null; then
      log_warning "Root privileges are required, please enter your password below."
      command sudo --validate
    fi
    command sudo "$@"
  fi
}

git_clean(){
  path=$(realpath "$1")
  remote="$2"
  branch="$3"

  log_task "Cleaning '${path}' with remote '${remote} and branch '${branch}'"
  git="git -C ${path}"
  ${git} checkout -B "${branch}"
  ${git} fetch "${remote}" "${branch}"
  ${git} reset --hard FETCH_HEAD
  ${git} clean -fdx
  unset path remote branch git
}

DOTFILES_REPO_HOST=${DOTFILES_REPO_HOST:-"https://github.com"}
DOTFILES_USER=${DOTFILES_REPO_USER:-"nitheesh-me"}
DOTFILES_REPO="${DOTFILES_REPO_HOST}/${DOTFILES_USER}/dotfiles.git"
DOTFILES_BRANCH=${DOTFILES_BRANCH:-"main"}
DOTFILES_DIR=${DOTFILES_DIR:-"$HOME/.dotfiles"}

if ! command -v git >/dev/null 2>&1; then
  log_task "Installing git"
  sudo apt update --yes
  sudo apt install --yes git
fi

if [ -d "${DOTFILES_DIR}" ]; then
  git_clean "${DOTFILES_DIR}" "${DOTFILES_REPO}" "${DOTFILES_BRANCH}"
else
  log_task "Cloning '${DOTFILES_REPO}' to '${DOTFILES_DIR}'"
  git clone --recursive --branch "${DOTFILES_BRANCH}" "${DOTFILES_REPO}" "${DOTFILES_DIR}"
fi

if [ -f "${DOTFILES_DIR}/install.sh" ]; then
  INSTALL_SCRIPT="${DOTFILES_DIR}/install.sh"
elif [ -f "${DOTFILES_DIR}/install" ]; then
  INSTALL_SCRIPT="${DOTFILES_DIR}/install"
else
  error "No install script found in '${DOTFILES_DIR}'"
fi

log_task "Running '${INSTALL_SCRIPT}'"
exec "${INSTALL_SCRIPT}"
