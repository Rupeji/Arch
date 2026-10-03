#!/bin/bash

# Salir inmediatamente si ocurre algún error
set -e

echo "=== [1/6] Verificando e instalando el asistente AUR (yay) ==="
if ! command -v yay &> /dev/null; then
    echo "¡yay no está instalado! Clonando y compilando desde el repositorio oficial..."
    # Instalar dependencias necesarias para compilar en Arch
    sudo pacman -S --needed --noconfirm base-devel git
    
    # Crear directorio temporal para la compilación
    rm -rf /tmp/yay-bin
    git clone https://aur.archlinux.org/yay.git /tmp/yay-bin
    
    # Compilar e instalar de forma segura como usuario normal
    cd /tmp/yay-bin
    makepkg -si --noconfirm
    cd - # Volver al directorio original del script
else
    echo "✔ yay ya se encuentra instalado en el sistema."
fi

echo "=== [2/6] Instalando Kitty, Fish y cambiando Shell por defecto ==="
sudo pacman -S --needed --noconfirm kitty fish

# Obtener la ruta exacta de donde se instaló fish
FISH_PATH=$(which fish)

# Asegurar que fish está en la lista de shells permitidos del sistema (/etc/shells)
if ! grep -q "^$FISH_PATH$" /etc/shells; then
    echo "Añadiendo Fish a la lista de shells seguros del sistema..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

# Cambiar de forma permanente el shell de tu usuario actual a Fish
echo "Cambiando tu shell predeterminado a Fish..."
sudo chsh -s "$FISH_PATH" "$USER"

echo "=== [3/6] Aplicando tus configuraciones respaldadas ==="
# Asegurar que el directorio de configuraciones existe
mkdir -p ~/.config

# Copiar configuración de Kitty si la carpeta existe en el repositorio
if [ -d "./kitty" ]; then
    echo "Copiando configuración local de Kitty a ~/.config/kitty..."
    rm -rf ~/.config/kitty
    cp -r ./kitty ~/.config/
else
    echo "⚠ Alerta: No se encontró la carpeta './kitty' al lado del script."
fi

# Copiar configuración de Fish si la carpeta existe en el repositorio
if [ -d "./fish" ]; then
    echo "Copiando configuración local de Fish a ~/.config/fish..."
    rm -rf ~/.config/fish
    cp -r ./fish ~/.config/
else
    echo "⚠ Alerta: No se encontró la carpeta './fish' al lado del script."
fi

echo "=== [4/6] Instalando dependencias de personalización avanzada ==="
# Software base del vídeo (Blur, Material You y efectos de fondo)
yay -S --noconfirm kvantum \
                    kwin-effects-better-blur-dx-git \
                    kde-material-you-colors-git \
                    plasma6-applets-wallpaper-effects

echo "=== [5/6] Descargando los TEMAS DEL VÍDEO (Fluent y Klassy) ==="
# Suite Klassy (Bordes redondos) y el ecosistema visual Fluent
yay -S --noconfirm klassy-bin \
                    plasma6-themes-fluent-git \
                    fluent-icon-theme-git

echo "=== [6/6] Automatizando las Reglas de Ventana (Opacidad al 85%) ==="
mkdir -p ~/.config/kwinrulesrc.d/
cat << 'EOF' > ~/.config/kwinrulesrc
Description=Efecto Transparencia del Video
opacityactive=100
opacityactiverule=2
opacityinactive=85
opacityinactiverule=2
types=1
wmclass=not important
wmclasscomplete=false
wmclassmatch=0
EOF

# Forzar al sistema a arrancar en modo oscuro para que los temas coordinen bien
kwriteconfig6 --file kdeglobals --group General --key ColorScheme BreezeDark || true

# Activar el demonio en segundo plano de los colores dinámicos
systemctl --user enable --now kde-material-you-colors.service || true

echo "=========================================================================="
echo "    ¡INSTALACIÓN, CONFIGURACIÓN Y CAMBIO DE SHELL COMPLETADOS!"
echo "=========================================================================="
echo "1. Tu terminal Kitty y tu shell Fish ya tienen tus archivos aplicados."
echo "2. ¡Fish ya es tu shell por defecto! Se activará al abrir tu terminal."
echo "3. REINICIA EL EQUIPO para aplicar el cambio de shell y el motor de Blur."
echo "4. Al volver, activa Klassy, Fluent y Kvantum en las Preferencias."
echo "=========================================================================="
