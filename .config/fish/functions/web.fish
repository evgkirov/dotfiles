function web --description 'alias web docker compose run --rm web'
  if test -f ./bin/django.sh
    ./bin/django.sh $argv
  else
    docker compose run --rm web $argv
  end
end
