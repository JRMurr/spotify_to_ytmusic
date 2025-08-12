{
  lib,
  python3Packages,
}:
let

  fs = lib.fileset;

  baseDir = ../.;

  python_files = fs.fileFilter (file: file.hasExt "py") baseDir;

in

python3Packages.buildPythonApplication {
  pname = "spotify-to-ytmusic";
  version = "1.11.0";

  src = fs.toSource {
    root = baseDir;
    fileset = fs.unions [
      python_files
      ../pdm.lock
      ../pyproject.toml
      ../spotify_to_ytmusic/settings.ini.example
    ];
  };

  pyproject = true;

  build-system = with python3Packages; [
    pdm-backend
    setuptools
    setuptools-scm
  ];

  dependencies = with python3Packages; [
    ytmusicapi
    spotipy
    platformdirs
  ];

}
