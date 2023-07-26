---
title: "AzureDevops: "
date: 2023-07-23T21:30:00-00:00
comments: true
draft: true
tags:
  - Azure
  - Azure DevOps
---

Para realizar a build ou o deploy de sua aplicação no Azure Pipelines, você precisa ter disponível pelo menos um Agent do Azure DevOps para realizar esta tarefa.
Para isso você tem duas opções:
- **Microsoft-hosted agents (recomendado):** Agents pré-definidos pela Microsoft, com eles você não precisa se preocupar com manutenção ou atualizações, é o jeito mais fácil de conseguir rodar suas pipelines.
- **Self-hosted agents:** Agents instalados no seu servidor e configurado por você mesmo.

# Instalando e Configurando um Agent (Windows)

Você consegue instalar um Agent em máquinas Linux, Windows ou MacOS.
Inclusive, é possível instalar até em um container do Docker.

## Instalando um novo Agent

- Acesse as configurações do projeto.

![](2023-07-23-22-13-13.png)

- Vá até **Agent Pools > Default > Agents**.
- Clique em **New Agent**.

![](2023-07-23-22-11-55.png)

- Faça download do Agent. Por padrão, o arquivo vai ser baixado na pasta "Downloads", deixe lá.

![](2023-07-23-22-14-26.png)

- Execute o Powershell como administrador, navegue até o diretório raiz **C:/** e crie a pasta "agent".
```ps1
mkdir agent ; cd agent
```
- Faça extração do arquivo .zip instalado:
```ps1
Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$HOME\Downloads\vsts-agent-win-x64-3.220.5.zip", "$PWD")
```
> **Observação:** execute o comando que aparece no modal do Azure DevOps, o trecho acima pode estar desatualizado.
- Configure o Agent:
```ps1
.\config.cmd
```
- É importante prestar atenção em algumas perguntas que a instalação vai fazer, você deve responder de acordo com suas necessidades, mas vou mostrar como fiz:

| Comando | Resposta | 
| --- | --- |
| Enter server url | https://dev.azure.com/<nome_organizacao> | 
| Enter authentication type | Enter | 
| Enter personal access token | (Preencher com seu PAT, ver abaixo como gerar um) | 
| Enter agent pool | Enter | 
| Enter agent name | Enter | 
| Enter work folder | Enter | 

## Gerando um PAT para o Agent (Personal Access Token)

- Acesse o menu de PAT.

![](2023-07-23-22-33-06.png)

- Crie um novo Personal Access Token apenas com permissão para "Agent Pools (Read & Manager)".

![](2023-07-23-22-34-15.png)

- Copie o token e cole na instalação do Agent.

- Conclusão da instalação:

![](2023-07-23-22-23-41.png)


> **Observações:** a Microsoft recomenda instalar apenas um Agent por máquina. Não seguir essa recomendação pode afetar a performance e o resultado da execução de sua pipeline.

# Editando a pipeline para utilizar o novo Agent

Agora que o Agent está pronto, vamos precisar configurar a pipeline para utilizá-lo.

**azure-pipelines.yml**
```
trigger:
- main

pool:
  name: Default
  demands:
    - agent.name -equals NOME_DO_SEU_AGENT
```

No arquivo de pipeline, altere a pool para "Default" e substitua NOME_DO_SEU_AGENT pelo nome do Agent que foi configurado.