# Auto-generated by fogg. Do not edit
# Make improvements in fogg, so that everyone can benefit.

SELF_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

include $(SELF_DIR)/common.mk

all:
.PHONY: all

setup:
	$(MAKE) -C $(REPO_ROOT) setup

check: lint check-plan
.PHONY: check

fmt: terraform
	@$(SHELL) -c 'printf "running fmt: "; for f in $(TF); do printf .; terraform fmt $$f; done';
	@echo
.PHONY: fmt

lint: terraform-validate lint-terraform-fmt lint-tflint
.PHONY: lint

lint-tflint: init
	@if (( $$TFLINT_ENABLED )); then \
    $(SHELL) -c 'tflint' || exit $$?; \
	fi
.PHONY: lint-tflint

terraform-validate: terraform init
	@$(SHELL) -c 'terraform validate -check-variables=true'
.PHONY: terraform-validate

lint-terraform-fmt: terraform
	@$(SHELL) -c 'for f in $(TF); do printf .; terraform fmt --check=true --diff=true $$f || exit $$? ; done'
.PHONY: lint-terraform-fmt

ifeq ($(MODE),local)
plan: init fmt
	@terraform plan
else ifeq ($(MODE),atlantis)
plan: init lint
	@terraform plan -input=false -no-color -out $PLANFILE | scenery
else
	@echo "Unknown MODE: $(MODE)" \
	@exit -1
endif
.PHONY: plan

ifeq ($(MODE),local)
apply: init
	terraform apply -auto-approve=$(AUTO_APPROVE)
else ifeq ($(MODE),atlantis)
apply:
	terraform apply -auto-approve=true $PLANFILE
else
	echo "Unknown mode: $(MODE)"
	exit -1
endif
.PHONY: apply

docs:
	echo
.PHONY: docs

clean:
	-rm -rfv .terraform/modules
	-rm -rfv .terraform/plugins
.PHONY: clean

test:
.PHONY: test

init: terraform
ifeq ($(MODE),local)
	@terraform init -input=false
else ifeq ($(MODE),atlantis)
	@terraform init -input=false -no-color > /tmp/out.txt 2>&1 || (a=$?; echo $a && cat /tmp/out.txt; exit $a)
else
	@echo "Unknown MODE: $(MODE)" \
	@exit -1
endif
.PHONY: init

check-plan: init
	@terraform plan -detailed-exitcode; \
	ERR=$$?; \
	if [ $$ERR -eq 0 ] ; then \
		echo "Success"; \
	elif [ $$ERR -eq 1 ] ; then \
		echo "Error in plan execution."; \
		exit 1; \
	elif [ $$ERR -eq 2 ] ; then \
		echo "Diff";  \
	fi
.PHONY: check-plan

run:
	terraform $(CMD)
.PHONY: run
