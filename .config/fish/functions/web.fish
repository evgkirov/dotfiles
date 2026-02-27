function web --description 'run Django command (prefer dev script when available)'
    if test -f ./bin/dev-django.sh
        ./bin/dev-django.sh $argv
    else
        docker compose run --rm web $argv
    end
end
