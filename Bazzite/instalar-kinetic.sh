#!/usr/bin/env bash
set -ox pipefail

# 1. Inyectamos los repositorios Copr oficiales
curl -Lo /etc/yum.repos.d/_copr_theblackdon-kineticwe.repo https://fedorainfracloud.org
curl -Lo /etc/yum.repos.d/_copr_lionheartp-Hyprland.repo https://fedorainfracloud.org

# 2. Ejecutamos la sustitución atómica estilo Don
rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:theblackdon:kineticwe kwin kwin-common kwin-libs kglobalacceld kdecoration

# 3. Forzar a Fish como la shell predeterminada del sistema
sed -i 's/\/bin\/bash/\/usr\/bin\/fish/g' /etc/default/useradd
