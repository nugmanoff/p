dev: hooks

hooks:
	ln -s -f ../../.githooks/pre-push .git/hooks/pre-push

run_tests:
	find ./test -type f -name "*.bats" | xargs bats

.SILENT: run_tests hooks

