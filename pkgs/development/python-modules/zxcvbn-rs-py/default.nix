{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  rustPlatform,
  cargo,
  rustc,
}:

buildPythonPackage rec {
  pname = "zxcvbn-rs-py";
  version = "0.1.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "fief-dev";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-hy23vyS78B78B5NHk0CU11awfpJD2aeD9dEWbCR9q6c=";
  };

  cargoDeps = rustPlatform.importCargoLock { lockFile = ./Cargo.lock; };

  build-system = [ rustPlatform.maturinBuildHook ];

  nativeBuildInputs = [
    cargo
    rustPlatform.cargoSetupHook
    rustc
  ];

  meta = with lib; {
    description = "Python bindings for zxcvbn-rs, the Rust implementation of zxcvbn";
    homepage = "https://github.com/fief-dev/zxcvbn-rs-py";
    changelog = "https://github.com/fief-dev/zxcvbn-rs-py/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ hulr ];
  };
}
