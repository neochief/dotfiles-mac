alias release="git checkout release && git pull --rebase origin release && git merge master && git push origin release && git checkout master"

alias selenium="selenium-server -port 4444"
alias cc="vendor/bin/codecept"
alias ccr="vendor/bin/codecept run"
alias ccra="vendor/bin/codecept run acceptance"
alias ccrf="vendor/bin/codecept run functional"

export PHPRC=~/.dotfiles/www/conf/php/php-cli.ini
alias art="php artisan"
alias c="composer"
alias acc="php artisan cache:clear"
alias phprestart="sudo brew services restart php70"