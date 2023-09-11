{ pkgs ? import ./pkgs.nix }:
pkgs.terraform.withPlugins (plugins: [
  plugins.azurerm
])
