.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: takeargs
takeargs: ## run the takes_args script with additional arguments, e.g. make takeargs ARGUMENTS="foo bar"
	@scripts/takes_args $(ARGUMENTS)

buildpackage: ## build the package
	@echo "building package"

installdeps: ## install dependencies
	@cd scripts && ./installdeps

installpackage: ## installs latest package
	@scripts/installpackage
