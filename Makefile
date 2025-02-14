# Conditionally include .env file if not running in CI/CD environment
ifndef GITHUB_ACTIONS
  -include .env
endif

# default env values
APTOS_NETWORK ?= custom
ARTIFACTS_LEVEL ?= sparse
DEFAULT_FUND_AMOUNT ?= 100000000
DEFAULT_FUNDER_PRIVATE_KEY ?= 0x0
DEV_ACCOUNT ?= 0x0133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a
LIBS_ADDRESS ?= 0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d

# ============================= CLEAN ============================= #
clean:
	rm -rf build

# ===================== PACKAGE AMM ===================== #

compile:
	movement move compile \
	--save-metadata \
	--included-artifacts ${ARTIFACTS_LEVEL} \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)"

test:
	movement move test \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)" \
	--coverage

publish:
	movement move create-object-and-publish-package \
	--included-artifacts ${ARTIFACTS_LEVEL} \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)" \
	--address-name razor_libs

upgrade:
	movement move upgrade-object \
	--address-name razor_libs \
	--included-artifacts ${ARTIFACTS_LEVEL} \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)" \
	--object-address $(LIBS_ADDRESS)

docs:
	movement move document \
	--named-addresses "razor_libs=$(LIBS_ADDRESS)"
