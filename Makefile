.PHONY: build
build:
	moon build --target wasm
	firefly_cli build

.PHONY: run
run:
	firefly-emulator --id applejag.moonbit-test
