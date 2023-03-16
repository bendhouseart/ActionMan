.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

%:
	@:

args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

.PHONY: takeargs
takeargs: ## run the takes_args script with additional arguments, e.g. make takeargs arg1 arg2"
	@scripts/takes_args $(call args, )

buildpackage: ## build the package
	@echo "building package"

installdeps: ## install dependencies
	@echo "cd scripts && ./installdeps"

installpackage: ## installs latest package
	@echo "scripts/installpackage"

buildrusthello: ## compiles rusthello
	@cd scripts && rustc hello_world.rs

rusthello:
	@cd scripts && ./hello_world

dotwothings: buildrusthello rusthello## does two things 