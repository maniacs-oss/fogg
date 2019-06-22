# Auto-generated by fogg. Do not edit
# Make improvements in fogg, so that everyone can benefit.

TF_VARS := $(patsubst %,-e%,$(filter TF_VAR_%,$(.VARIABLES)))
REPO_ROOT := $(shell git rev-parse --show-toplevel)
REPO_RELATIVE_PATH := $(shell git rev-parse --show-prefix)
AUTO_APPROVE := false
# We need to do this because `terraform fmt` recurses into .terraform/modules
# and wont' accept more than one file at a time.
TF=$(wildcard *.tf)

TFENV_DIR ?= $(REPO_ROOT)/.fogg/tfenv
export PATH :=$(TFENV_DIR)/versions/$(TERRAFORM_VERSION)/:$(REPO_ROOT)/.fogg/bin:$(PATH)
export TF_PLUGIN_CACHE_DIR=$(REPO_ROOT)/.terraform.d/plugin-cache
export TF_IN_AUTOMATION=1
terraform_command ?= $(TFENV_DIR)/versions/$(TERRAFORM_VERSION)/terraform
MODE ?= local

ifeq ($(MODE),atlantis)
	export AWS_CONFIG_FILE=$(REPO_ROOT)/config/atlantis-aws-config
	TF_ARGS ?= -no-color
endif


tfenv:
	@if [ ! -d ${TFENV_DIR} ]; then \
		git clone -q https://github.com/tfutils/tfenv.git $(TFENV_DIR); \
	fi
.PHONY: tfenv

terraform: tfenv
	${TFENV_DIR}/bin/tfenv install $(TERRAFORM_VERSION)
.PHONY: terraform
