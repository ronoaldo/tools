# ronoaldo/tools

Este projeto consiste de uma série de scripts, configurações,
e pequenos programas que eu uso em meu cotidiano de sysadmin,
entusiasta linux, desenvolvedor e hacker.

## Instalação

Você pode clonar o projeto no diretório de sua preferência,
mas eu recomendo o setup em seu $HOME ou $HOME/workspace:

	hg clone https://bitbucket.org/ronoaldo/tools ~/tools
	~/tools/bin/path-manager --configure
	~/tools/bin/path-manager --add $HOME/tools/bin

Os comandos acima configuram o seu ~/.bashrc para usar o path-manager,
basta reiniciar o shell ou fazer um ```soruce ~/.bashrc``` para
que os scripts fiquem sem seu ```$PATH```.

# Custom VIM

Este é o meu .vimrc que foi configurado para trabalhar com diferentes
linguagens de programação, como Go, Python, JavaScript e Java (Maven).

## Utilizando em seu .vimrc

Para utilizar, você pode fazer o download da versão atualizada com o comando:

    wget https://bitbucket.org/ronoaldo/tools/raw/tip/etc/vimrc -O ~/.vimrc

... ou incluir o diretório em seu .vimrc com o comando ```source```:

	echo 'source ~/tools/etc/vimrc' >> ~/.vimrc

## Atualizando plugins

Quando uma nova versão do etc/vimrc existir, ou para atualizar os
plugins do Vundle, você pode usar comandos do vim:

    vim +BundleInstall +BundleUpdate +BundleClean +qall

... ou utilizar o script bin/vim-update-bundles:

	vim-update-bundles --clean

# Overview das ferramentas

* benchmarkemail.py: interface de linha de comandos para o BenchmarkEmail
* colorscheme: script para exibir o esquema de cores no seu terminal
* dns-dump: dump de configurações básicas de DNS utilizando o Dig
* documentofacil: script para gerar cpf/cnpj e copiar para o clipboard
* dpkg-purge-all: expurga todos os pacotes que possuem configuração residual
* geocode: interface de linha de comandos para o Google Maps geocoding
* gmail: ferramenta para envio de e-mails via CLI utilizando o SMTP do Gmail
* jardiff: mostra a diferença de 'layout' entre dois arquivos JAR/ZIP
* kernelbuild: utilitário para baixar e compilar o Linux como pacote .deb
* license-header: adiciona cabeçalho de licença Apache 2 a scripts shell/python
* markdown-preview: servidor de preview de arquivos Markdown
* maven-alternate-settings: alterna entre arquivos de configuração do maven
  via links symbólicos
* maven-search: interface de linha de comandos para busca no Maven Central
* maven-update-completion: atualiza o bash-completion dos plugins Maven
* nitrous-io-backup: backup para seus arquivos do Nitrous.IO para S3
* p2-install: instala plugins no Eclipse via linha de comandos
* path-manager: gerencia seu $PATH de maneira simples
* replicate: replica o mesmo comando em subdiretórios do diretório corrente
* s3-repository: implementação simples de repositório Debian usando S3
* update-hgrc: atualiza configurações do seu .hg/hgrc
* vim-update-bundles: atualiza os plugins com Vundle que estão ativos no vimrc
* wpa-connect: interface de conexão a redes Wifi via linha de comandos
* zipit: ferramenta para compactar diretórios como arquivo zip
