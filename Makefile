dev: hooks

hooks:
	ln -s -f ../../.githooks/pre-push .git/hooks/pre-push

run_tests:
	
	fd ".*.bats" | xargs bats