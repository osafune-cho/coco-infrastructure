{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "terraform-provider-vercel";
  version = "0.15.1";

  subPackages = [ "." ];

  src = fetchFromGitHub {
    owner = "vercel";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-SkEP/TrcTK+IfRdmS/DFakNtpAFnoeBh4VkhX/DgStA=";
  };

  vendorSha256 = "sha256-e9nfRBWq9uJey+IHMMA8yx3oAJzQdTOtBZZV1VOxxtc=";
  provider-source-address = "registry.terraform.io/vercel/vercel";
  postInstall = ''
    dir=$out/libexec/terraform-providers/${provider-source-address}/${version}/''${GOOS}_''${GOARCH}
    mkdir -p $dir
    mv $out/bin/* "$dir/terraform-provider-$(basename ${provider-source-address})_${version}"
    rmdir $out/bin
  '';

  meta = with lib; {
    homepage = "https://registry.terraform.io/providers/vercel/vercel";
    description = "";
    license = licenses.mpl20;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
