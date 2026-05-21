{ stdenv, lib, autoPatchelfHook, src }:

stdenv.mkDerivation {
  pname = "android-cli";
  version = "latest";

  inherit src;

  dontUnpack = true;

  nativeBuildInputs = lib.optionals stdenv.isLinux [ autoPatchelfHook ];

  installPhase = ''
    runHook preInstall
    install -Dm755 $src $out/bin/android
    runHook postInstall
  '';

  meta = {
    description = "Android CLI, the official command-line interface for Android development";
    homepage = "https://developer.android.com/tools/agents/android-cli";
    mainProgram = "android";
    platforms = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ];
  };
}
