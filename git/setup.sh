
setup_git() {
  local git_cfgsrc_dir="$(get_dir "${BASH_SOURCE[0]}")"

  # main config
  #link .gitconfig intoplace
  if [ -f ${HOME}/.gitconfig ]; then
    mv ${HOME}/.gitconfig ${HOME}/.gitconfig.old
  fi

  lnif "${git_cfgsrc_dir}/gitconfig" ${HOME}/.gitconfig
  #extra config stuff we just link this entire directory to $HOME/.gitconfig.d
  lnif ${git_cfgsrc_dir} "${HOME}/.gitconfig.d"
}
