install:
	sudo ./install.sh

uninstall:
	rm -f /usr/local/bin/p
	sudo rm -rf /usr/local/libexec/p

dev: hooks

hooks:
	ln -s -f ../../.githooks/pre-push .git/hooks/pre-push

run_tests:
	find ./test -type f -name "*.bats" | xargs bats

.SILENT: run_tests hooks install uninstall

