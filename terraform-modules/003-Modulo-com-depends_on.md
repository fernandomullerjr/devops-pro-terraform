
# Aula - Módulo com variables e outputs


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
git commit -m "Terraform Modules - 003 Módulo com depends_on."
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

# Módulo com depends_on


- Copiando o módulo pets e adaptando para criar um segundo pets:

~~~~h
module "pets01" {
  source          = "./modules/pets"
  prefixo_arquivo = "teste-arquivo-01"
}

module "pets02" {
  source          = "./modules/pets"
  prefixo_arquivo = "teste-arquivo-02"
}
~~~~





- Ajustando o outputs do módulo raíz, devido a mudança do nome dos módulos:

devops-pro-terraform/terraform-modules/002-materiais/outputs.tf

~~~~h
output "nome_pet01" {
  value = module.pets01.nome_01
}

output "nome_pet02" {
  value = module.pets02.nome_02
}
~~~~






~~~~
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ ls -lhasp
total 52K
4.0K drwxr-xr-x 4 fernando fernando 4.0K Mar 25 21:58 ./
4.0K drwxr-xr-x 4 fernando fernando 4.0K Mar 29 19:59 ../
4.0K -rw-r--r-- 1 fernando fernando  193 Mar 29 20:44 main.tf
4.0K drwxr-xr-x 3 fernando fernando 4.0K Mar 25 21:20 modules/
4.0K -rw-r--r-- 1 fernando fernando  112 Mar 29 20:45 outputs.tf
4.0K drwxr-xr-x 4 fernando fernando 4.0K Mar 25 21:20 .terraform/
4.0K -rw-r--r-- 1 fernando fernando 2.2K Mar 25 21:20 .terraform.lock.hcl
8.0K -rw-r--r-- 1 fernando fernando 4.1K Mar 25 21:58 terraform.tfstate
8.0K -rw-r--r-- 1 fernando fernando 4.8K Mar 25 21:58 terraform.tfstate.backup
4.0K -rwxr-xr-x 1 fernando fernando   16 Mar 25 21:40 testando-prefixo--arquivo.txt
4.0K -rwxr-xr-x 1 fernando fernando   15 Mar 25 21:40 testando-prefixo--outro_arquivo.txt
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform plan
╷
│ Error: Module not installed
│
│   on main.tf line 1:
│    1: module "pets01" {
│
│ This module is not yet installed. Run "terraform init" to install all modules required by this configuration.
╵
╷
│ Error: Module not installed
│
│   on main.tf line 6:
│    6: module "pets02" {
│
│ This module is not yet installed. Run "terraform init" to install all modules required by this configuration.
╵
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform init
Initializing modules...
- pets01 in modules/pets
- pets02 in modules/pets

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/local from the dependency lock file
- Reusing previous version of hashicorp/random from the dependency lock file
- Using previously-installed hashicorp/local v2.4.0
- Using previously-installed hashicorp/random v3.4.3

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$
~~~~