#!/bin/bash

echo "Iniciando a configuração de ambiente..."

# 1. Atualização e Dependências Oficiais
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm base-devel linux-headers git unzip qemu-base seatd cage xorg-xwayland polkit curl

# 2. Compilação e Instalação do Yay (se ausente)
if ! command -v yay &> /dev/null; then
    echo "Yay não encontrado. Compilando..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
fi

# 3. VMware: Instalação e Serviços
yay -S --noconfirm vmware-workstation
sudo modprobe -a vmw_vmci vmmon
sudo systemctl enable --now vmware-networks.service
sudo systemctl enable --now vmware-usbarbitrator.service

# 4. Seatd: Permissões de Vídeo Wayland
sudo systemctl enable --now seatd
sudo usermod -aG seat $USER

# 5. Autologin no TTY1 (Via systemd override para não abrir editor interativo)
echo "Injetando autologin no TTY1 para o usuário $USER..."
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
cat <<EOF | sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\\\u' --noclear --autologin $USER %I \$TERM
EOF

# 6. Inicialização do Cage no .bash_profile
if ! grep -q "cage -- vmware" ~/.bash_profile; then
    echo -e "\nif [[ -z \$DISPLAY ]] && [[ \$(tty) = /dev/tty1 ]]; then\n    exec cage -- vmware\nfi" >> ~/.bash_profile
fi

# 7. Preparação do OC4VM
mkdir -p ~/OC4VM_Setup && cd ~/OC4VM_Setup
curl -L -O https://github.com/DrDonk/OC4VM/releases/download/3.0.1/oc4vm-3.0.1.zip
unzip -o oc4vm-3.0.1.zip

# 8. Automação do recoveryOS (Injetando opções 7 e 1 via pipeline)
echo "Baixando a imagem do macOS..."
echo -e "7\n1\n" | ./tools/linux/recoveryOS

# Mover o arquivo criado (tratando variações de maiúsculas no diretório)
mv tools/*/tahoe.vmdk vmware/intel/ || echo "Aviso: tahoe.vmdk não encontrado no diretório esperado."


echo "======================================================"
echo "Automação finalizada! Reinicie o sistema executando: reboot"
echo "Após o boot, o Cage iniciará automaticamente."
echo "======================================================"