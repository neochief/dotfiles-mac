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

alias ssh1="ssh -i ~/.ssh/it-patrol.pem u4142@githowto.com"
alias ssh3="ssh forge@178.79.157.251"
alias ssh3d="ssh -R 9000:localhost:9000 forge@178.79.157.251"
alias ssh4="ssh forge@213.52.129.75"
alias ssh4d="ssh -R 9000:localhost:9000 forge@213.52.129.75"
alias sshradadata="ssh forge@136.243.72.94"
alias sshradadatad="ssh -R 9000:localhost:9000 forge@136.243.72.94"
alias sshradadata2="ssh forge@46.4.85.73"
alias sshradadatad2="ssh -R 9000:localhost:9000 forge@46.4.85.73"
alias sshproxy="ssh -D 12345 forge@178.79.157.251"

alias selenium="(cd ~; java -jar selenium-server-standalone-2.45.0.jar)"
alias cc="vendor/bin/codecept"
alias ccr="vendor/bin/codecept run"
alias ccra="vendor/bin/codecept run acceptance"
alias ccrf="vendor/bin/codecept run functional"
alias phpunit="vendor/bin/phpunit"
alias pu="vendor/bin/phpunit"
