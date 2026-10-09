# yaml-language-server: $schema=https://blue-build.org
name: bazzite-kineticwe
description: Imagen personalizada de Bazzite con el entorno de mosaico KineticWE, Kitty y la shell Fish.

# Descarga de la imagen base oficial de Bazzite (KDE)
base-image: ghcr.io/ublue-os/bazzite
image-version: stable

modules:
  # 1. Gestión de repositorios e instalación con el módulo DNF oficial de BlueBuild
  - type: dnf
    repos:
      copr:
        - theblackdon/kineticwe   # Repo principal de KineticWE
        - lionheartp/Hyprland     # Provee los paquetes base de Noctalia Shell
    install:
      - kineticwe    # Reemplaza atómicamente a kwin, kglobalacceld, etc.
      - noctalia-git # Shell oficial que acompaña al entorno KineticWE
      - kitty        # Emulador de terminal por GPU seleccionado
      - fish         # Shell interactiva por defecto
