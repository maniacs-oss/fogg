# Auto-generated by fogg. Do not edit
# Make improvements in fogg, so that everyone can benefit.

SELF_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

include $(SELF_DIR)/common.mk

all: fmt lint doc

fmt: terraform
	$(sh_command) -c 'for f in $(TF); do printf .; terraform fmt $$f; done'; \
	echo

check: lint check-docs

lint: lint-tf

lint-tf: terraform
	@$(sh_command) -c 'for f in $(TF); do printf .; terraform fmt --check=true --diff=true $$f || exit $$? ; done'

readme:
	bash $(REPO_ROOT)/scripts/update-readme.sh update

docs: readme

check-docs:
	@bash $(REPO_ROOT)/scripts/update-readme.sh check; \
	if [ ! $$? -eq 0 ];  then \
		echo "Docs are out of date, run \`make docs\`"; \
	fi

clean:

test:

.PHONY: all check-doc clean docs fmt lint lint-tf readme test