# yaml-language-server: $schema=https://blue-build.org
version: 1
name: bazzite-kineticwe
description: Imagen estilo 'Donzzite' de Bazzite con el entorno KineticWE, Kitty y Fish.

base-image: ghcr.io/ublue-os/bazzite-nvidia
image-version: stable

modules:
  # 1. Habilitamos AMBOS repositorios Copr requeridos por el autor
  - type: dnf
    repos:
      copr:
        - theblackdon/kineticwe # Código base de KineticWE
        - lionheartp/Hyprland   # Dependencias esenciales de Noctalia / Wayland

  # 2. Reemplazo simultáneo de KWin (Método para evitar bloqueos en la ISO)
  - type: script
    scripts:
      - |
        #!/usr/bin/env bash
        set -ox pipefail
        dnf swap -y kwin kineticwe --allowerasing
        dnf swap -y kwin-common kineticwe --allowerasing
        dnf swap -y kwin-libs kineticwe --allowerasing
        dnf swap -y kglobalacceld kineticwe --allowerasing
        dnf swap -y kdecoration kineticwe --allowerasing

  # 3. Instalación de la interfaz gráfica y tus herramientas de terminal
  - type: dnf
    install:
      packages:
        - noctalia   # La shell oficial (provista gracias a los repos habilitados)
        - kitty      # Terminal por GPU
        - fish       # Shell interactiva
