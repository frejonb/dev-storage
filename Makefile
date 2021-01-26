release:
	@if [ "$(shell uname)" = "Darwin" ]; then \
		which gsed; test $$? -eq 0 || (echo "Please install gsed: brew install gnu-sed"; exit 1); \
	fi
	test -n "$(version)"
	@VERSION=$(shell bash -c "$$(wget -O - 'https://raw.githubusercontent.com/fsaintjacques/semver-tool/3.0.0/src/semver')" '' bump $(version) $(shell sed -n "s/\(.*\)/\1/p" "version.txt")); \
	echo $$VERSION > version.txt; \
	if [ "$(shell uname)" = "Darwin" ]; then \
		gsed -i "s/fernandorejonbarrera\/dev-storage:\(.*\)/fernandorejonbarrera\/dev-storage:$$VERSION/g" "deploy/k8s.yaml"; \
	elif [ "$(shell uname)" = "Linux" ]; then \
		sed -i "s/fernandorejonbarrera\/dev-storage:\(.*\)/fernandorejonbarrera\/dev-storage:$$VERSION/g" "deploy/k8s.yaml"; \
	else \
		echo "$(shell uname) not supported"; exit 1; \
	fi; \
	docker build -t fernandorejonbarrera/dev-storage:$$VERSION .; \
	docker push fernandorejonbarrera/dev-storage:$$VERSION .;