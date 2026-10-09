# yaml-language-server: $schema=https://blue-build.org
version: 1
name: bazzite-kineticwe
description: Imagen estilo 'Donzzite' de Bazzite con el entorno KineticWE, Kitty y Fish.

base-image: ghcr.io/ublue-os/bazzite-nvidia
image-version: stable

modules:
  # 1. REPOSITORIOS: Don habilita explícitamente estas dos fuentes Copr
  - type: copr
    repos:
      - theblackdon/kineticwe   # Repositorio de Don para el fork de KWin
      - lionheartp/Hyprland     # Dependencias de Wayland / Noctalia requeridas

  # 2. EL REEMPLAZO (El núcleo de lo que puede fallar):
  # En lugar de borrar con scripts, se le ordena al sistema atómico "sustituir"
  # los componentes base por KineticWE en un solo movimiento limpio.
  - type: rpm-ostree
    replace:
      - package: kwin
        with: kineticwe
      - package: kwin-common
        with: kineticwe
      - package: kwin-libs
        with: kineticwe
      - package: kglobalacceld
        with: kineticwe
      - package: kdecoration
        with: kineticwe

  # 3. PURGA DE BAZZITE (Lo que menciona en el minuto 6:22 del video)
  # Don explica que elimina el "Bazzite Portal" y el actualizador porque no los necesita.
  - type: rpm-ostree
    remove:
      - bazzite-portal
      - bazzite-updater

  # 4. INSTALACIÓN DE SU ECOSISTEMA DIARIO (Vía RPM nativo)
  - type: rpm-ostree
    install:
      - noctalia        # La shell tiling oficial que usa sobre KineticWE
      - kitty           # Terminal acelerada por GPU
      - fish            # Shell interactiva predeterminada
      - dolphin         # Administrador de archivos nativo
      - obs-studio      # Software de grabación/transmisión
      - discord         # Cliente de comunicación nativo de Fedora

  # 5. CONFIGURACIÓN DEL SISTEMA
  - type: script
    scripts:
      - |
        #!/usr/bin/env bash
        set -ox pipefail
        # Cambia la shell por defecto para que las nuevas cuentas arranquen directamente en Fish
        sed -i 's/\/bin\/bash/\/usr\/bin\/fish/g' /etc/default/useradd
