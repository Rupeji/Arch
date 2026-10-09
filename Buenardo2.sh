# yaml-language-server: $schema=https://blue-build.org
version: 1
name: bazzite-kineticwe
description: Imagen personalizada de Bazzite con el entorno de mosaico KineticWE, Kitty y la shell Fish.

# Tu base elegida (Mantiene todas las optimizaciones de Bazzite)
base-image: ghcr.io/ublue-os/bazzite-nvidia
image-version: stable

modules:
  # 1. Configurar los repositorios COPR primero
  - type: dnf
    repos:
      copr:
        - theblackdon/kineticwe # Repo principal de KineticWE
        
  # 2. Forzar el reemplazo de componentes del sistema de forma segura
  - type: script
    scripts:
      - |
        #!/usr/bin/env bash
        set -ox pipefail
        # Para que rpm-ostree / dnf permita el intercambio atómico del compositor base:
        dnf swap -y kwin kineticwe --allowerasing
        dnf swap -y kwin-common kineticwe --allowerasing
        dnf swap -y kwin-libs kineticwe --allowerasing
        dnf swap -y kglobalacceld kineticwe --allowerasing
        dnf swap -y kdecoration kineticwe --allowerasing

  # 3. Instalar el resto de herramientas de usuario sin conflictos
  - type: dnf
    install:
      packages:
        - noctalia   # La shell oficial de Kinetic
        - kitty      # Terminal por GPU
        - fish       # Shell interactiva
