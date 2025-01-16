SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
# .DELETE_ON_ERROR:
MAKEFLAGS = --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules


# Override PWD so that it's always based on the location of the file and **NOT**
# based on where the shell is when calling `make`. This is useful if `make`
# is called like `make -C <some path>`
PWD := $(realpath $(dir $(abspath $(firstword $(MAKEFILE_LIST)))))
# Using $$() instead of $(shell) to run evaluation only when it's accessed
# https://unix.stackexchange.com/a/687206
py = $$(if [ -d $(PWD)/'.venv' ]; then echo $(PWD)/".venv/bin/python3"; else echo "python3"; fi)
poetry = poetry

##@ Development

.PHONY: clean
clean:  ## Clean up local dev env
	rm -rf .venv

.PHONY: lockfile
lockfile: poetry.lock  ## Re-generate poetry.lock
poetry.lock: pyproject.toml
	poetry lock --no-update

.PHONY: setup
setup: .venv  ## Set up your local dev env
.venv: pyproject.toml
	$(py) -m venv .venv
	source .venv/bin/activate && $(poetry) install --no-root
	touch .venv

.PHONY: serve
serve: setup  ## Start a local server
	poetry run mkdocs serve

.PHONY: build
build: setup ## Build the doc site
	poetry run mkdocs build

##@ Others

.DEFAULT_GOAL := help
.PHONY: help
help: ## Display this help section
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo
