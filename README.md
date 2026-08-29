# macOS sobre Arch Linux via VMware

Este projeto é um conjunto de automações para preparar um host Arch Linux minimal e rodar uma instalação do macOS em uma máquina virtual, com foco em compatibilidade e portabilidade entre diferentes computadores.

A ideia central é permitir executar o macOS em hardware que normalmente não seria suportado por um hackintosh tradicional, sem depender de um MacBook real. Em vez de depender de suporte nativo do hardware, o sistema é montado em uma VM, com foco em um host dedicado e em ambientes em que a compatibilidade do sistema operacional é mais importante do que desempenho gráfico.

## Objetivo

O objetivo deste port é permitir desenvolver com Xcode e trabalhar com ferramentas da plataforma Apple sem possuir um Mac real. Ele foi pensado para quem precisa de um ambiente macOS funcional para desenvolvimento, testes e uso básico em um computador comum.

## Vantagens

- Compatibilidade maior em comparação com hackintoshs tradicionais de macOS em hardware não oficialmente suportado.
- Funciona em computadores mais genéricos, inclusive em hosts que não são compatíveis com instalação nativa do macOS. Testado em um notebook Asus com i5 1235U
- Em um host dedicado, é possível alocar mais recursos para a máquina virtual.
- Em testes pessoais, consegui dedicar até 8 núcleos para a VM em um host dedicado, enquanto em hosts Windows ou Linux desktop o uso mais comum ficou em torno de 4 núcleos.
- O projeto automatiza grande parte da preparação inicial do ambiente em Arch Linux.

## Limitações

Este setup não oferece aceleração gráfica por hardware. Isso significa que ele é adequado apenas para tarefas básicas e desenvolvimento leve, não para uso exigente em 3D, edição de vídeo, jogos ou qualquer workload que dependa fortemente de GPU acelerada.

Em outras palavras:

- Boa opção para desenvolvimento com Xcode e ferramentas de software.
- Não é ideal para uso diário com alto desempenho gráfico.
- A experiência visual será limitada pela virtualização, sem aceleração nativa da GPU.

## Como funciona

O fluxo do projeto automatiza a preparação do host Arch Linux e a criação da VM para macOS:

1. Atualiza o sistema e instala dependências do Arch.
2. Instala o gerenciador de pacotes AUR e ferramentas como VMware Workstation.
3. Configura serviços essenciais do sistema e autologin em TTY.
4. Prepara o ambiente para iniciar a VM automaticamente via Cage.
5. Baixa e prepara o OpenCore/OC4VM para montar o sistema macOS.
6. Automatiza a geração da imagem e da configuração inicial do ambiente.

O script principal está em [AutoSetup.sh](AutoSetup.sh), e as etapas manuais complementares estão descritas em [InstrucoesManuais.md](InstrucoesManuais.md).

## Requisitos

- Arch Linux instalado e funcionando.
- Usuário com acesso sudo.
- VMware Workstation disponível e compatível com o host.
- Hardware com suporte suficiente para virtualização.
- Memória e CPU suficientes para alocar uma VM macOS com desempenho aceitável.

## Observações importantes

- Este projeto não é uma solução oficial da Apple.
- O comportamento pode variar conforme o hardware, a versão do macOS e o ambiente de virtualização.
- O foco principal é conveniência, compatibilidade e desenvolvimento, e não desempenho gráfico máximo.

## Uso

1. Clone este repositório.
2. Verifique os arquivos e ajuste conforme sua necessidade.
3. Execute o script:

```bash
chmod +x AutoSetup.sh
./AutoSetup.sh
```

4. Reinicie o sistema quando o script terminar.
5. Siga os passos manuais contidos em [InstrucoesManuais.md](InstrucoesManuais.md).

## Resumo

Este projeto nasceu da necessidade de desenvolver com Xcode sem um MacBook real, mantendo o ambiente o mais compatível possível em hardware geral. O ponto forte do setup é a flexibilidade e a capacidade de aproveitar melhor os recursos em um host dedicado. Apesar das limitações gráficas, ele atende bem a cenários de desenvolvimento e uso básico do macOS em máquinas que não seriam viáveis com soluções tradicionais.

> Esse port foi feito para permitir desenvolvimento em macOS de forma prática, mesmo em computadores comuns, com foco em compatibilidade e produtividade.

## Créditos

Este projeto usa a base de automação e infraestrutura do OC4VM, desenvolvido por [DrDonk](https://github.com/DrDonk) e colaboradores do projeto [OC4VM](https://github.com/DrDonk/OC4VM).

Agradeço ao time e aos contribuidores do OC4VM por disponibilizar a base técnica que tornou esse setup possível e por permitir a execução do macOS em ambientes virtuais com uma abordagem prática e extremamente útil para desenvolvimento.

Caso encontre algum bug ou melhoria, sinta-se livre para entrar em contato.
Da mesma maneira, se gostou do trabalho e quiser me pagar um café, segue o link do BuyMeACoffee: https://buymeacoffee.com/retrocommander