# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  zgen oh-my-zsh

  zgen oh-my-zsh lib/completion.zsh
  zgen load zsh-users/zsh-completions src

  zgen load zsh-users/zsh-history-substring-search
  zgen oh-my-zsh plugins/command-not-found
  zgen load Tarrasch/zsh-bd

  # zsh-autosuggestions depend on syntax highlighting
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load tarruda/zsh-autosuggestions

  zgen load romkatv/powerlevel10k powerlevel10k

  zgen save
fi

zle -N autosuggest_start

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=/usr/local/bin:"$HOME/.cargo/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias openstack='docker run -it --rm -v ~/.ssh:$HOME/.ssh:ro -e OS_AUTH_URL -e OS_IDENTITY_API_VERSION -e OS_USER_DOMAIN_NAME -e OS_PROJECT_DOMAIN_NAME -e OS_TENANT_ID -e OS_TENANT_NAME -e OS_PROJECT_DOMAIN_NAME -e OS_USERNAME -e OS_PASSWORD -e OS_REGION_NAME ullbergm/openstack-client:latest openstack'