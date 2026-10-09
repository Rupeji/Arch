# yaml-language-server: $schema=https://blue-build.org
name: bazzite-kineticwe
description: Imagen personalizada de Bazzite con el entorno de mosaico KineticWE, Kitty y la shell Fish.

# Descarga de la imagen base oficial de Bazzite (KDE + Nvidia)
base-image: ghcr.io/ublue-os/bazzite-nvidia
image-version: stable

modules:
  # 1. Habilitar los repositorios COPR necesarios
  - type: copr
    enable:
      - theblackdon/kineticwe   # Repo principal de KineticWE
      - lionheartp/Hyprland     # Provee los paquetes base de Noctalia Shell

  # 2. Reemplazo atómico e instalación
  - type: rpm-ostree
    # Eliminamos primero los paquetes stock conflictivos para que KineticWE los pueda sustituir
    override-remove:
      - kwin
      - kwin-common
      - kwin-libs
      - kglobalacceld
      - kdecoration
    install:
      - kineticwe    # Ahora sí se instalará reemplazando los anteriores sin conflictos
      - noctalia-git # Shell oficial del entorno
      - kitty        # Emulador de terminal por GPU
      - fish         # Shell interactiva
