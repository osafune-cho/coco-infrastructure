{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "terraform-provider-cloudflare";
  version = "4.10.0";

  subPackages = [ "." ];

  src = fetchFromGitHub {
    owner = "cloudflare";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Zj8CC+Xiej+gz9V/9IeIGaWP2cjIg6jboXN5jrBCosM=";
  };

  vendorSha256 = "sha256-hxD+0OrCdyYn/9nvz5fd/54YiaZyZMOfsIa7lqZhCHE=";
  provider-source-address = "registry.terraform.io/cloudflare/cloudflare";
  postInstall = ''
    dir=$out/libexec/terraform-providers/${provider-source-address}/${version}/''${GOOS}_''${GOARCH}
    mkdir -p $dir
    mv $out/bin/* "$dir/terraform-provider-$(basename ${provider-source-address})_${version}"
    rmdir $out/bin
  '';

  meta = with lib; {
    homepage = "https://registry.terraform.io/providers/cloudflare/cloudflare/latest";
    description = "Cloudflare Terraform Provider";
    license = licenses.mpl20;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
