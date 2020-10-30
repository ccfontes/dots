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

  git config --global push.default current
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
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH=/usr/local/bin:"$HOME/.cargo/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# 
# # Checkout branch by id
# git config --global alias.xout "!xout() {
#     local index=$1
#     local branches=$(git branch | grep "[^* ]+" -Eo)
#     local counter=0
# 
#     echo "$branches" | while IFS= read -r branch ; do
#         counter=$((counter+1))
#         if [ "$index" -eq "$counter" ]; then
#             git checkout $branch
#         fi
#     done
# }"

# List branches by id
#git config --global alias.branches '!sh git branch --no-color | cat -n'
#git config --global alias.xout '!git_xout'


alias openstack='docker run -it --rm -v ~/.ssh:$HOME/.ssh:ro -e OS_AUTH_URL -e OS_IDENTITY_API_VERSION -e OS_USER_DOMAIN_NAME -e OS_PROJECT_DOMAIN_NAME -e OS_TENANT_ID -e OS_TENANT_NAME -e OS_PROJECT_DOMAIN_NAME -e OS_USERNAME -e OS_PASSWORD -e OS_REGION_NAME ullbergm/openstack-client:latest openstack'

alias fig=docker-compose

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export OPENFAAS_URL=http://127.0.0.1:8080


# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
