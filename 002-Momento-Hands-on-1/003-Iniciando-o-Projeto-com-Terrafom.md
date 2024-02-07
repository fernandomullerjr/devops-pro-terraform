
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
# Iniciando o Projeto com Terrafom


- Usaremos este provider
<https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs>


## PENDENTE
- Ver com o Fabricio sobre os links e materiais na parte inferior do video.
- Comandos de apoio:
terraform apply -var-file=.terraform.tfvars

