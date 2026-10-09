# yaml-language-server: $schema=https://blue-build.org
name: bazzite-kineticwe
description: Imagen personalizada de Bazzite con el entorno de mosaico KineticWE, Kitty y la shell Fish.

# Descarga de la imagen base oficial de Bazzite (KDE)
base-image: ghcr.io/ublue-os/bazzite
image-version: stable

modules:
  # 1. Habilitar el repositorio COPR oficial de KineticWE
  - type: copr
    repos:
      - theblackdon/kineticwe

  # 2. Reemplazo crítico de paquetes (Recomendación nativa del creador)
  - type: script
    snippets:
      - |
        echo "=== INICIANDO INSTALACIÓN DE KINETICWE ==="
        # DNF gestiona el reemplazo automático eliminando kwin y derivados gracias a las reglas del RPM
        dnf install -y kineticwe noctalia-git
        dnf clean all
        echo "=== REEMPLAZO COMPLETADO NATIVAMENTE ==="

  # 3. Instalación de tus herramientas preferidas de terminal
  - type: rpm-ostree
    install:
      - kitty   # Reemplaza a kconsole/foot como emulador de terminal por GPU
      - fish    # Tu nueva shell interactiva por defecto
