HOST ?= schroedinger
# HOST ?= shitbox
NIX_ARGS = --extra-experimental-features "nix-command flakes"
ASROOT = sudo
# ASROOT = doas

# Luks
KEYCPY_MAIN_FILE = ./secrets/luks/main.key
KEYCPY_MAIN_TARGET = /luks-main.key

# Disko
DISKO_ARGS = --mode disko

.PHONY: bootstrap format rebuild sys-install

bootstrap: format sys-install

format:
	@echo "> Copying luks keys"
	$(ASROOT) install -Dm400 $(KEYCPY_MAIN_FILE) $(KEYCPY_MAIN_TARGET)
	@echo "> Formatting the disk"
	$(ASROOT) nix $(NIX_ARGS) run github:nix-community/disko#disko -- $(DISKO_ARGS) --flake .#$(HOST)

rebuild: keycpy
	@echo "> Rebuilding the system"
	$(ASROOT) nixos-rebuild switch --flake .#$(HOST)

sys-install:
	@echo "> Installing NixOS"
	$(ASROOT) nixos-install --flake .#$(HOST) --no-root-password
