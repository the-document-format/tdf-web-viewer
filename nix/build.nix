{
  pnpm,
  stdenv,
  nodejs,
  fetchPnpmDeps,
  pnpmConfigHook,
}:
stdenv.mkDerivation rec {
  pname = "The Document Format Web Viewer";
  version = "0.1.0";
  src = ../.;

  buildInputs = [
    nodejs
    pnpmConfigHook
    pnpm
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit pname version src;
    fetcherVersion = 3;
    hash = "sha256-pabl7CT8WNEwZND22TX3TdtdWvkBZKzd9rcUho9O66c=";
  };

  SHOW_UPDATED = "false";
  FETCH_RESUME = "false";

  buildPhase = ''
    mkdir $out
    pnpm build
    cp -r dist $out
  '';
}
