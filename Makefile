# Conditionally include .env file if not running in CI/CD environment
ifndef GITHUB_ACTIONS
  -include .env
endif

# default env values
APTOS_NETWORK ?= custom
ARTIFACTS_LEVEL ?= sparse
DEFAULT_FUND_AMOUNT ?= 100000000
DEFAULT_FUNDER_PRIVATE_KEY ?= 0x0
DEV_ACCOUNT ?= 0xfaded96b72a03b2ed9e2b2dc0bef0642d63e07fd7b1eeeac047188eb1ef34dd6
LIBS_ADDRESS ?= 0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d

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
	aptos move test \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)" \
	--coverage

publish-testnet:
	movement move create-object-and-publish-package \
	--included-artifacts ${ARTIFACTS_LEVEL} \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)" \
	--address-name razor_libs

publish-mainnet:
	movement move create-object-and-publish-package \
	--included-artifacts ${ARTIFACTS_LEVEL} \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)" \
	--address-name razor_libs \
	--profile mainnet

upgrade-testnet:
	movement move upgrade-object-package \
	--included-artifacts ${ARTIFACTS_LEVEL} \
	--named-addresses "razor_libs=$(LIBS_ADDRESS)" \
	--override-size-check \
	--object-address $(LIBS_ADDRESS)

upgrade-mainnet:
	movement move upgrade-object-package \
	--included-artifacts ${ARTIFACTS_LEVEL} \
	--named-addresses "razor_libs=$(LIBS_ADDRESS)" \
	--object-address $(LIBS_ADDRESS) \
	--override-size-check \
	--profile mainnet

docs:
	movement move document \
	--named-addresses "razor_libs=$(LIBS_ADDRESS)"
