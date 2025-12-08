{
  stdenv,
  swift,
  apple-sdk,
}:
stdenv.mkDerivation rec {
  pname = "notch-height";
  version = "0.0.0";

  src = ./.;

  nativeBuildInputs = [ swift ];

  buildInputs = [ apple-sdk ];

  buildPhase = ''
    swiftc -o notch-height notch-height.swift
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp notch-height $out/bin/notch-height
  '';

  meta = {
    mainProgram = "notch-height";
    description = "A simple utility to get the height of the MacBook notch";
  };
}
