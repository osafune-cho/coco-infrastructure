self: super: {
  terraform-providers = super.terraform-providers // {
    azurerm = super.callPackage ./terraform-provider-azurerm.nix { };
    random = super.callPackage ./terraform-provider-random.nix { };
  };
}
