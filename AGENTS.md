# Dotfiles

macOS dotfiles managed with GNU Stow. The repo root is the stow directory — any file/directory structure here (except ignored paths) gets symlinked into `$HOME`.

## Project structure

```
macos/                    # macOS-specific scripts and configs
  bootstrap.d/            # Scripts run during initial bootstrap (numbered for ordering)
  dump_config.d/          # Scripts that export current system config to files
  post_install.d/         # Scripts run after install (defaults, dock, services)
  Brewfile                # Homebrew bundle file
  install.sh              # Installs packages from Brewfile
  upgrade.sh              # Updates Homebrew and runs install
scripts/                  # Top-level orchestration scripts
  bootstrap.sh            # Initial setup (clone repo, set remote, run bootstrap.d/)
  install.sh              # Run platform install + stow dotfiles
  post_install.sh         # Run platform post-install scripts
  upgrade.sh              # Run platform upgrade
  dump_config.sh          # Run platform config dump scripts
  utils.sh              # Shared utilities (formatting helpers, run_dir)
```

## How scripts are executed

All scripts are invoked from the **repo root** via `Makefile` targets (`make install`, `make upgrade`, etc.). The one exception is `scripts/bootstrap.sh`, which is designed to run standalone via `curl | bash` for initial setup before the repo is cloned.

Because of this:

-   All `. scripts/utils.sh` source paths are relative to the repo root
-   `scripts/bootstrap.sh` has formatting functions **inlined** since `utils.sh` isn't available yet when it runs remotely; it sources `utils.sh` after cloning the repo to get `run_dir`

Scripts in `macos/*.d/` directories are executed by the `run_dir` function from `scripts/utils.sh`, which iterates over `*.sh` files in alphabetical order. Files are numbered (e.g., `00-`, `10-`, `20-`) to control execution order.

## Formatting conventions

Scripts use `scripts/utils.sh` for consistent terminal output:

-   `fmt_header "..."` — bold blue `==>` prefix, for top-level section titles
-   `fmt_step "..."` — cyan `-->` prefix, for individual action steps
-   `fmt_info "..."` — dimmed text, for supplementary information
-   `fmt_success "..."` — green text, for completion messages
-   `fmt_warning "..."` — yellow text, for non-fatal warnings
-   `fmt_run_script "..."` — cyan arrow + dimmed path, used by `run_dir`

## Makefile targets

-   `make bootstrap` — initial machine setup
-   `make install` — install packages + stow dotfiles
-   `make post_install` — apply system defaults, dock layout, start services
-   `make upgrade` — update Homebrew + upgrade packages + re-install
-   `make dump_config` — export current system config to repo files
-   `make check_stow` — dry-run stow to check for conflicts
