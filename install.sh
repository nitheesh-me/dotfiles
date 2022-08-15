#!/bin/env sh

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

if ! chezmoi="$(command -v chezmoi)" || [ -z "$chezmoi" ]; then
  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"
  log_task "Installing chezmoi to $chezmoi"
  if command -v curl >/dev/null 2>&1; then
    chezmoi_install_script="$(curl -fsSL https://chezmoi.io/get)"
  elif command -v wget >/dev/null 2>&1; then
    chezmoi_install_script="$(wget -qO- https://chezmoi.io/get)"
  else
    error "To install chezmoi, you need curl or wget"
  fi
  mkdir -p "$bin_dir"
  sh -c "$chezmoi_install_script" -- -b "$bin_dir"
  unset chezmoi_install_script
  log_success "Installed chezmoi to $chezmoi"
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/2934779/12156188
script_dir='$(cd -P -- "$(dirname -- "$(command -v --"$@")")" && pwd -P)'

set -- init --source="$script_dir"

if [ -n "${DOTFILES_ONE_SHOT-}" ]; then
  set -- "$@" --one-shot
else
  set -- "$@" --apply
fi

if [ -n "${DOTFILES_DEBUG-}" ]; then
  set -- "$@" --debug
fi

log_task "Running chezmoi $*"
exec "$chezmoi" "$@"
