# Descarga de la imagen base oficial de Bazzite (KDE)
base-image: ghcr.io/ublue-os/bazzite
image-version: latest # Asegúrate de que incluya Qt 6.11 o superior requerido por el autor

name: bazzite-kineticwe
description: Imagen personalizada de Bazzite con el entorno de mosaico KineticWE y Noctalia Shell.

modules:
  # 1. Habilitar los repositorios COPR necesarios
  - type: yum-repo
    repos:
      - theblackdon/kineticwe   # Repo oficial del autor
      - lionheartp/Hyprland     # Requerido opcionalmente o según dependencias cruzadas

  # 2. Reemplazo crítico de paquetes (Recomendación estricta del creador)
  # Usamos un script de shell inline para ejecutar el override remove e install de forma atómica
  - type: script
    snippets:
      - |
        echo "Eliminando componentes stock de KWin e instalando KineticWE..."
        rpm-ostree override remove kwin kwin-common kwin-libs kglobalacceld kdecoration \
          --install kineticwe --install noctalia-git

  # 3. Paquetes adicionales sugeridos por el autor para la sesión mínima
  - type: rpm-ostree
    install:
      - console       # Emulador de terminal preferido
      - foot          # Terminal Wayland ultraligero alternativo

  # 4. Configurar servicios por defecto si es necesario (ej. SDDM)
  - type: default-flatpaks
