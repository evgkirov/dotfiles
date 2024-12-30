function af1 --wraps='ssh -t dokku@af1' --description 'alias af1 ssh -t dokku@af1'
  ssh -t dokku@af1 $argv
end
