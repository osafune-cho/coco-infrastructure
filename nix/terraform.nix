{ pkgs ? import ./pkgs.nix }:
pkgs.terraform.withPlugins (plugins: [
  plugins.azurerm
  plugins.random
  plugins.cloudflare
  plugins.vercel
])
