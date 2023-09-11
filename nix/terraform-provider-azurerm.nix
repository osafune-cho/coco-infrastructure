{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "terraform-provider-azurerm";
  version = "3.72.0";

  subPackages = [ "." ];

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-I6rZvScFJsnoYtm+RtkzoHtnCrys1vy5gQ2pOzQ/8JU=";
  };

  vendorSha256 = null;
  provider-source-address = "registry.terraform.io/hashicorp/azurerm";
  postInstall = ''
    dir=$out/libexec/terraform-providers/${provider-source-address}/${version}/''${GOOS}_''${GOARCH}
    mkdir -p $dir
    mv $out/bin/* "$dir/terraform-provider-$(basename ${provider-source-address})_${version}"
    rmdir $out/bin
  '';

  meta = with lib; {
    homepage = "https://registry.terraform.io/providers/hashicorp/azurerm";
    description = "Lifecycle management of Microsoft Azure using the Azure Resource Manager APIs. maintained by the Azure team at Microsoft and the Terraform team at HashiCorp";
    license = licenses.mpl20;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
