{
  fetchFromGitHub,
  stdenv,
  nodejs,
  pnpm,
  pnpmConfigHook,
  fetchPnpmDeps,
  nix-update-script,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "difit";
  version = "2.2.7";
  src = fetchFromGitHub {
    owner = "yoshiko-pg";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    sha256 = "sha256-1YMGvzjHW0XKtMK0uRradFdRAFlCK+EeR768GYeTunY=";
  };

  nativeBuildInputs = [
    pnpm
    pnpmConfigHook
  ];

  buildInputs = [
    nodejs
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 3;
    hash = "sha256-yYQTuv42XZpmD73F5yHAKOnMY220zczduDb4nOuwzDY=";
  };

  buildPhase = ''
    runHook preBuild

    pnpm build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,lib/difit}
    cp -r {package.json,dist,node_modules} $out/lib/difit
    chmod +x $out/lib/difit/dist/cli/index.js
    ln -s $out/lib/difit/dist/cli/index.js $out/bin/difit

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };
})
