# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`

if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
  alias l="gls -lAh --color"
fi

alias vimb="vim ~/.bash_profile"
alias vimz="vim ~/.zshrc"
alias vimp="vim ~/.profile"

alias ssh5="ssh forge@139.162.205.196"
alias ssh5d="ssh -R 9000:localhost:9000 forge@139.162.205.196"
alias ssh6="ssh forge@139.162.220.169"
alias ssh6d="ssh -R 9000:localhost:9000 forge@139.162.220.169"
alias ssh1="ssh forge@213.219.36.225"
alias ssh1d="ssh -R 9000:localhost:9000 forge@213.219.36.225"
alias ssh2="ssh forge@139.162.183.165"
alias ssh2d="ssh -R 9000:localhost:9000 forge@139.162.183.165"
