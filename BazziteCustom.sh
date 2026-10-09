# yaml-language-server: $schema=https://schema.blue-build.org/recipe-v1.json
name: bazzite-kineticwe
description: Imagen personalizada de Bazzite con el entorno de mosaico KineticWE, Kitty y la shell Fish.

# Descarga de la imagen base oficial de Bazzite (KDE + Nvidia)
base-image: ghcr.io/ublue-os/bazzite-nvidia
image-version: stable

modules:
  # Gestión de repositorios y paquetes mediante el módulo oficial DNF
  - type: dnf
    repos:
      copr:
        - theblackdon/kineticwe  # Repo principal de KineticWE
        - lionheartp/Hyprland    # Provee los paquetes base de Noctalia Shell
    remove:
      - kwin
      - kwin-common
      - kwin-libs
      - kglobalacceld
      - kdecoration
    install:
      - kineticwe  # Sustituye de forma segura a los eliminados
      - noctalia-git  # Shell oficial
      - kitty  # Terminal por GPU
      - fish  # Shell interactiva
