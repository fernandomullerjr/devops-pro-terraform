

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

# Git - Efetuando Push
git status
git add -u
git reset -- terraform-modules/001-materiais/.terraform
git reset -- terraform-modules/001-materiais/.terraform/*
git reset -- terraform-modules/001-materiais/terraform.tfstate
git reset -- terraform-modules/001-materiais/terraform.tfstate.backup
git reset -- terraform-modules/002-materiais/.terraform
git reset -- terraform-modules/002-materiais/.terraform/*
git reset -- terraform-modules/002-materiais/terraform.tfstate
git reset -- terraform-modules/002-materiais/terraform.tfstate.backup
git reset -- terraform-modules/005-materiais/.terraform
git reset -- terraform-modules/005-materiais/.terraform/*
git reset -- terraform-modules/005-materiais/terraform.tfstate
git reset -- terraform-modules/005-materiais/terraform.tfstate.backup
git commit -m "Terraform Modules - 005 Criando um módulo na prática."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status

- Git - add sem colocar .terraform:
git add -u
git reset -- 01-eks-cluster-terraform-simples/.terraform
git reset -- 01-eks-cluster-terraform-simples/.terraform/*






----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

# 005 Criando um módulo na prática

- Criar conta na Digital Ocean
https://cloud.digitalocean.com/droplets?i=15249b


- Gerar token
https://cloud.digitalocean.com/account/api/tokens?i=15249b
Fernando-token-Digital-Ocean-01-04-2023



### Autenticar o Terraform com a DigitalOcean

https://jssantos.net/2019/12/terraform-e-digitalocean-infra-as-code-nunca-foi-tao-simples/?doing_wp_cron=1680320012.8998219966888427734375

Antes de começar a fazer qualquer coisa, você precisa de um token de API da DigitalOcean. Você pode gerar um personal accestoken aqui.
Depois de gerar esse token, guarde-o numa variável de ambiente de nome DIGITALOCEAN_TOKEN ou DIGITALOCEAN_ACCESS_TOKEN.