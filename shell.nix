{ pkgs ? import nix/pkgs.nix }:
let
  terraform = import ./nix/terraform.nix { inherit pkgs; };
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    terraform
    nixpkgs-fmt
    azure-cli
    shellcheck
  ];
}
