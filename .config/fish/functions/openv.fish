function openv --wraps='op --env-file=./.env' --description 'alias openv op --env-file=./.env'
    op --env-file=./.env $argv
end
