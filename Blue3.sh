# yaml-language-server: $schema=https://schema.blue-build.org/recipe-v1.json
name: bazzite-kineticwe
description: Imagen personalizada de Bazzite con el entorno de mosaico KineticWE, Kitty y la shell Fish.

# Descarga de la imagen base oficial de Bazzite (KDE)
base-image: ghcr.io/ublue-os/bazzite
image-version: stable

modules:
  # 1. Habilitar el repositorio COPR oficial usando el módulo nativo de BlueBuild
  - type: yum-repo
    repos:
      - theblackdon/kineticwe

  # 2. Instalación y Reemplazo Nativo de Paquetes
  # El módulo rpm-ostree procesará el RPM de kineticwe, aplicando el 'obsoletes' automático sobre kwin
  - type: rpm-ostree
    install:
      - kineticwe    # Reemplaza atómicamente a kwin, kglobalacceld, etc.
      - noctalia-git # Shell oficial que acompaña al entorno KineticWE
      - kitty        # Emulador de terminal por GPU seleccionado
      - fish         # Shell interactiva por defecto
