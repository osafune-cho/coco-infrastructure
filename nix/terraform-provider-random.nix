{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "terraform-provider-random";
  version = "3.5.1";

  subPackages = [ "." ];

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-IsXKdS3B5kWY5LlNKM0fYjp2uM96ngi6vZ9F46MmfcA=";
  };

  vendorSha256 = "sha256-ScY/hAb14SzEGhKLpnJ8HrWOccwc2l0XW6t+f62LyWM=";
  provider-source-address = "registry.terraform.io/hashicorp/random";
  postInstall = ''
    dir=$out/libexec/terraform-providers/${provider-source-address}/${version}/''${GOOS}_''${GOARCH}
    mkdir -p $dir
    mv $out/bin/* "$dir/terraform-provider-$(basename ${provider-source-address})_${version}"
    rmdir $out/bin
  '';

  meta = with lib; {
    homepage = "https://registry.terraform.io/providers/hashicorp/random";
    description = "Supports the use of randomness within Terraform configurations. This is a logical provider, which means that it works entirely within Terraform logic, and does not interact with any other services.";
    license = licenses.mpl20;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
