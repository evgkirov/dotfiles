.PHONY: bootstrap
bootstrap:
	sh scripts/bootstrap.sh

.PHONY: install
install:
	sh scripts/install.sh

.PHONY: post_install
post_install:
	sh scripts/post_install.sh

.PHONY: upgrade
upgrade:
	sh scripts/upgrade.sh

.PHONY: dump_config
dump_config:
	sh scripts/dump_config.sh

.PHONY: outdated
outdated:
	sh scripts/outdated.sh

.PHONY: check_stow
check_stow:
	stow --simulate -vv -t $$HOME .

