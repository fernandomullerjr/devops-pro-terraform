
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "002 Momento Hands On - 002 Criando o Projeto no Terminal Web."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# Criando o Projeto no Terminal Web

- Acessar Digital Ocean

- Verificar as chaves SSH

~~~~BASH

fernando@debian10x64:~/.ssh$ ls -lhasp | grep debian10
4.0K -rw-------  1 fernando fernando 1.8K Jan  3  2022 chave-debian10-github
4.0K -rw-r--r--  1 fernando fernando  402 Jan  3  2022 chave-debian10-github.pub
fernando@debian10x64:~/.ssh$
fernando@debian10x64:~/.ssh$ date
Sun 04 Feb 2024 08:30:18 PM -03
fernando@debian10x64:~/.ssh$


~~~~




- Criar uma chave para uso no Digital Ocean:
ssh-keygen -t rsa -b 2048

~~~~bash
fernando@debian10x64:~/.ssh$ ls -lhasp | grep digital
4.0K -rw-------  1 fernando fernando 1.8K Feb  4 20:44 digital-ocean-fernando-04-02-2024
4.0K -rw-r--r--  1 fernando fernando  402 Feb  4 20:44 digital-ocean-fernando-04-02-2024.pub
fernando@debian10x64:~/.ssh$ date
Sun 04 Feb 2024 08:44:47 PM -03
fernando@debian10x64:~/.ssh$
~~~~


- Pegar o conteudo da chave e ir no painel do Digital Ocean
Settings
Security
Add a chave criada


- Criar um Droplet
ao invés de Password, utilizar SSH KEY na autenticação do Droplet


- Acessar via SSH, informando a chave nova.

- Agora no painel da Digital Ocean, criar um firewall.
Acessar:
Networking
Firewalls