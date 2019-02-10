with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "env";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    ninja
  ];

  shellHook =
    ''
      export SOURCE_DATE_EPOCH="315532800"
    '';
}
