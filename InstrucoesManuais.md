# Instruções Manuais Pós-Automação: macOS no VMware (Arch Linux/Wayland)

Este documento detalha os passos manuais que não puderam ser automatizados e devem ser executados **após** a execução do script `AutoSetup.sh` e o reinício do sistema.

## 1. Configuração da Máquina Virtual (Host)
*   Abra o arquivo `~/OC4VM_Setup/vmware/intel/macos.vmx` da sua máquina virtual.
*   **Configure Núcleos e Threads:** Caso esteja na VM Arch dedicada como indicado, você pode dedicar 2 processadores, com 4 núcleos cada.
*   **Mapeamento de Disco:** Adicione o arquivo `tahoe.vmdx` no mapeamento da máquina virtual.

## 2. Setup e Instalação do macOS
*   Inicie o instalador do MacOS na VM.
*   **Otimização de Desempenho:** Ao chegar no setup do Tahoe Instalado, aperte `Super+alt+F5` e selecione a opção de reduzir transparência para melhorar o desempenho no setup.
*   **Bypass do Loading Loop:** Após realizar a configuração final da conta, o instalador entrará em um *loading loop* na tela "Atualizar automaticamente o MacOS?". Aguarde de 10 a 15 minutos e depois force o reinício da VM.

## 3. Otimizações de Interface (Dentro do macOS)
Dentro da sessão do seu usuário, a aceleração gráfica estará desativada. Portanto, é recomendado realizar os seguintes passos:
*   **Wallpaper:** Troque o Wallpaper por uma imagem estática.
*   **Desativar LiquidGlass:** Abra o terminal e execute o seguinte comando:
    ```bash
    defaults write -g com.apple.SwiftUI.DisableSolarium -bool YES
    ```
*   **Instalação do VMware Tools:**
    1. Acesse a pasta `Opencore/OC4VM/isso/Darwin.iso` na área de trabalho e instale o VMWare Tools.
    2. O instalador irá falhar inicialmente. Nas configurações do macOS, dê a autorização para o VMWare iniciar em segundo plano e instale novamente. [cite: 2]

## 4. Patches do OpenCore (config.plist)
Adicione os seguintes códigos XML no arquivo `OPENCORE/EFI/OC/config.plist` (DENTRO DO MACOS).

### Patches do iCloud
Adicione os dois dicionários logo abaixo do dict com.apple.driver.AppleACPIPlatform:
```xml
<dict>
<key>Arch</key>
<string>x86_64</string>
<key>Base</key>
<string/>
<key>Comment</key>
<string>iCloud Patch Part 1</string>
<key>Count</key>
<integer>1</integer>
<key>Enabled</key>
<true/>
<key>Find</key>
<data>aGliZXJuYXRlaGlkcmVhZHkAaGliZXJuYXRlY291bnQA</data>
<key>Identifier</key>
<string>kernel</string>
<key>Limit</key>
<integer>0</integer>
<key>Mask</key>
<data/>
<key>MaxKernel</key>
<string/>
<key>MinKernel</key>
<string/>
<key>Replace</key>
<data>aGliZXJuYXRlaGlkcmVhZHkAaHZfdm1tX3ByZXNlbnQA</data>
<key>ReplaceMask</key>
<data/>
<key>Skip</key>
<integer>0</integer>
</dict>
<dict>
<key>Arch</key>
<string>x86_64</string>
<key>Base</key>
<string/>
<key>Comment</key>
<string>iCloud Patch Part 2</string>
<key>Count</key>
<integer>1</integer>
<key>Enabled</key>
<true/>
<key>Find</key>
<data>Ym9vdCBzZXNzaW9uIFVVSUQAaHZfdm1tX3ByZXNlbnQA</data>
<key>Identifier</key>
<string>kernel</string>
<key>Limit</key>
<integer>0</integer>
<key>Mask</key>
<data/>
<key>MaxKernel</key>
<string/>
<key>MinKernel</key>
<string/>
<key>Replace</key>
<data>Ym9vdCBzZXNzaW9uIFVVSUQAaGliZXJuYXRlY291bnQA</data>
<key>ReplaceMask</key>
<data/>
<key>Skip</key>
<integer>0</integer>
</dict>
```

## 5. Finalização
*   Reinicie seu MacOS.
