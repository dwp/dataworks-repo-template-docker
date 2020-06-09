SHELL:=bash

default: help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: bootstrap
bootstrap: ## Bootstrap local environment for first use
	make git-hooks

.PHONY: git-hooks
git-hooks: ## Set up hooks in .git/hooks
	@{ \
		git submodule update --init .githooks \
		git config core.hooksPath .githooks \
	}

.PHONY: terraform-init
terraform-init: ## Run `terraform init` from repo root
	terraform init terraform/deploy/

.PHONY: terraform-plan
terraform-plan: ## Run `terraform plan` from repo root
	terraform plan -var-file=terraform/deploy/terraform.tfvars terraform/deploy/

.PHONY: terraform-apply
terraform-apply: ## Run `terraform apply` from repo root
	terraform apply -var-file=terraform/deploy/terraform.tfvars terraform/deploy/
