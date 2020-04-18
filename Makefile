dev: hooks

hooks:
	ln -s -f ../../.githooks/pre-push .git/hooks/pre-push

.SILENT: run_tests
run_tests:
	find ./test -type f -name "*.bats" | xargs bats
