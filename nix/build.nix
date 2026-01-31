{
  lib,
  buildPnpmPackage,
}:
buildPnpmPackage {
  pname = "website";
  version = "0.1.0";

  src = ../.;

  npmDepsHash = lib.fakeHash;

  npmBuildScript = "build";

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r dist/* $out/
    runHook postInstall
  '';

  meta = with lib; {
    description = "Website";
    homepage = "https://github.com/example/website";
    license = licenses.mit;
    maintainers = [ ];
  };
}
