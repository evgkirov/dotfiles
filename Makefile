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

.PHONY: check_stow
check_stow:
	stow --simulate -vv -t $$HOME .

