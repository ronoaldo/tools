# ronoaldo/tools

Este projeto consiste de uma série de scripts, configurações,
e pequenos programas que eu uso em meu cotidiano de sysadmin,
entusiasta linux, desenvolvedor e hacker.

## Instalação

Você pode clonar o projeto no diretório de sua preferência,
mas eu recomendo o setup em seu $HOME ou $HOME/workspace:

	git clone https://github.com/ronoaldo/tools ~/tools
	~/tools/bin/path-manager --configure
	~/tools/bin/path-manager --add $HOME/tools/bin

Os comandos acima configuram o seu ~/.bashrc para usar o path-manager,
basta reiniciar o shell ou fazer um ```soruce ~/.bashrc``` para
que os scripts fiquem sem seu ```$PATH```.

# Overview das ferramentas

Cada ferramenta traz sua própria página de ajuda, então basta
utilizar o argumento -h ou --help para ver o funcionamento.

Para conveniência, consulte também a página [de ajuda](./docs/README.md)
na pasta docs/.
