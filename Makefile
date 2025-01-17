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
LIBS_ADDRESS ?= 0x08bb1284a91d591aa966b08db97be484aabbd08b69edd3a71be7459fda6bcb4f

# ============================= CLEAN ============================= #
clean:
	rm -rf build

# ===================== PACKAGE AMM ===================== #

compile:
	aptos move compile \
	--skip-fetch-latest-git-deps \
	--move-2 \
	--save-metadata \
	--included-artifacts ${ARTIFACTS_LEVEL} \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)"

test:
	aptos move test \
	--skip-fetch-latest-git-deps \
	--ignore-compile-warnings \
	--move-2 \
	--skip-attribute-checks \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)" \
	--coverage

publish:
	aptos move deploy-object \
	--move-2 \
	--skip-fetch-latest-git-deps \
	--included-artifacts ${ARTIFACTS_LEVEL} \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)" \
	--address-name razor_libs

upgrade:
	aptos move upgrade-object \
	--skip-fetch-latest-git-deps \
	--address-name razor_libs \
	--included-artifacts ${ARTIFACTS_LEVEL} \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)" \
	--object-address $(LIBS_ADDRESS)

docs:
	aptos move document \
	--move-2 \
	--skip-fetch-latest-git-deps \
	--skip-attribute-checks \
	--named-addresses "razor_libs=$(DEV_ACCOUNT)"
