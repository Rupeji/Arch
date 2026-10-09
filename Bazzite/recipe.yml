# yaml-language-server: $schema=https://blue-build.org
version: 1
name: bazzite-kineticwe
description: Imagen estilo 'Donzzite' de Bazzite con el entorno KineticWE, Kitty y Fish.

base-image: ghcr.io/ublue-os/bazzite-nvidia
image-version: stable

modules:
  # 1. EJECUCIÓN DEL SCRIPT (Sintaxis oficial homologada de BlueBuild)
  - type: script
    scripts:
      - instalar-kinetic.sh

  # 2. INSTALACIÓN NATIVA DE LAS APLICACIONES DIARIAS
  - type: rpm-ostree
    install:
      - noctalia
      - kitty
      - fish
      - dolphin
