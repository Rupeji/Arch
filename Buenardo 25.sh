# yaml-language-server: $schema=https://blue-build.org
version: 1
name: bazzite-kineticwe
description: Imagen personalizada de Bazzite con el entorno de mosaico KineticWE, Kitty y la shell Fish.

# Tu base elegida (Mantiene todas las optimizaciones de Bazzite)
base-image: ghcr.io/ublue-os/bazzite-nvidia
image-version: stable

modules:
  # Gestión unificada y atómica de repositorios y paquetes
  - type: dnf
    flags:
      allow-erasing: true  # Esto equivale nativamente al "--allowerasing" que intentabas meter en el script
    repos:
      copr:
        - theblackdon/kineticwe # Repo principal de KineticWE
    remove:
      packages:
        - kwin
        - kwin-common
        - kwin-libs
        - kglobalacceld
        - kdecoration
    install:
      packages:
        - kineticwe
        - noctalia   # La shell oficial de Kinetic
        - kitty      # Terminal por GPU
        - fish       # Shell interactiva
