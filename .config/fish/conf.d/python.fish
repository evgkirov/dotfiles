if status is-interactive

    function venv_create
        set -l python_exec $argv[1]
        test -z "$python_exec"; and set python_exec python3
        venv_deactivate
        if test -f "requirements.txt"
            rm -rf .venv
            $python_exec -m venv .venv
            source .venv/bin/activate.fish
            pip install --upgrade pip
            pip install -r requirements.txt
        else if test -f "pyproject.toml"
            poetry install
        else if test -f "agbackend/pyproject.toml"
            poetry -C agbackend install
        end
    end

    function venv_activate --on-variable PWD
        venv_deactivate
        if test -f ".venv/bin/activate.fish"
            source .venv/bin/activate.fish
        else if test -f "pyproject.toml"
            eval (poetry env activate)
        else if test -f "agbackend/pyproject.toml"
            eval (poetry -C agbackend env activate)
        end
    end

    function venv_deactivate
        functions -q deactivate; and deactivate
    end

    function venv_upgrade
        venv_activate
        if test -f "requirements.txt"
            pip install --upgrade pip
            pip install --upgrade -r requirements.txt
        else if test -f "pyproject.toml"
            poetry install --sync
        else if test -f "agbackend/pyproject.toml"
            poetry -C agbackend install --sync
        end
    end

    function venv_sync
        venv_activate
        if test -f "requirements.txt"
            pip install -r requirements.txt
        else if test -f "pyproject.toml"
            poetry install --sync
        else if test -f "agbackend/pyproject.toml"
            poetry -C agbackend install --sync
        end
    end

    # Auto-activate venv
    venv_activate

end
