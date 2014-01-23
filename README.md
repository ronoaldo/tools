# Canivete Suíço

Este projeto consiste de uma série de scripts, configurações,
e pequenos programas que eu uso em meu cotidiano de sysadmin,
entusiasta linux, desenvolvedor e hacker.

# Custom VIM

Este é o meu .vimrc que foi configurado para trabalhar com diferentes
linguagens de programação, como Python, JavaScript e Java (Maven).

Para instalar:

    wget https://bitbucket.org/ronoaldo/tools/raw/tip/etc/vimrc -O ~/.vimrc

Para atualizar:

    vim +BundleInstall +BundleUpdate +BundleClean +qall

# Ferramentas Inclusas

* benchmarkemail.py: interface de linha de comandos para o BenchmarkEmail 
* colorscheme: script para exibir o esquema de cores no seu terminal
* dns-dump: dump de configurações básicas de DNS utilizando o Dig
* documentofacil: script para gerar cpf/cnpj e copiar para o clipboard
* dpkg-purge-all: expurga todos os pacotes que possuem configuração residual
* geocode: interface de linha de comandos para o Google Maps geocoding
* gmail: ferramenta para envio de e-mails via CLI utilizando o SMTP do Gmail
* jardiff: mostra a diferença de 'layout' entre dois arquivos Jar
* kernelbuild: utilitário para baixar e compilar o Linux como pacote .deb
* license-header: adiciona cabeçalho de licença Apache 2
* markdown-preview: preview de arquivos Markdown via web.
* maven-alternate-settings: alterna entre arquivos de configuração do maven 
  via links symbólicos
* maven-search: interface de linha de comandos para busca no Maven Central
* maven-update-completion: atualiza o bash-completion dos plugins Maven
* nitrous-io-backup: backup para seus arquivos do Nitrous.IO para S3
* p2-install: instala plugins no Eclipse via linha de comandos
* path-manager: gerencia seu $PATH de maneira simples e fácil
* replicate: replica o mesmo comando em subdiretórios do diretório corrente
* s3-repository: implementação simples de repositório Debian usando S3
* update-hgrc: atualiza configurações do seu .hg/hgrc
* wpa-connect: interface de conexão a redes Wifi via linha de comandos
* zipit: ferramenta para compactar diretórios como arquivo zip
