


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
git commit -m "Terraform Modules - 001 Criando um módulo."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status

- Git - add sem colocar .terraform:
git add -u
git reset -- 01-eks-cluster-terraform-simples/.terraform
git reset -- 01-eks-cluster-terraform-simples/.terraform/*




- Arquivo de exemplo que será usado na aula:

~~~~h
resource "local_file" "arquivo" {
  content  = random_pet.pet01.id
  filename = "arquivo.txt"
}

resource "local_file" "outro_arquivo" {
  content  = random_pet.pet02.id
  filename = "outro_arquivo.txt"
}

resource "random_pet" "pet01" {
}


resource "random_pet" "pet02" {
}
~~~~





- Acessar o diretório onde foi criado o main.tf:

/home/fernando/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais/
executar o terraform init
vai baixar o provider e plugins

~~~~bash
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ ls -lhasp
total 12K
4.0K drwxr-xr-x 2 fernando fernando 4.0K Mar 24 22:05 ./
4.0K drwxr-xr-x 3 fernando fernando 4.0K Mar 24 22:05 ../
4.0K -rw-r--r-- 1 fernando fernando  275 Mar 24 22:06 main.tf
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/random...
- Finding latest version of hashicorp/local...
- Installing hashicorp/random v3.4.3...
- Installed hashicorp/random v3.4.3 (signed by HashiCorp)
- Installing hashicorp/local v2.4.0...
- Installed hashicorp/local v2.4.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$
~~~~





- Efetuando apply:

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.arquivo will be created
  + resource "local_file" "arquivo" {
      + content              = (known after apply)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "arquivo.txt"
      + id                   = (known after apply)
    }

  # local_file.outro_arquivo will be created
  + resource "local_file" "outro_arquivo" {
      + content              = (known after apply)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

Plan: 4 to add, 0 to change, 0 to destroy.
random_pet.pet02: Creating...
random_pet.pet01: Creating...
random_pet.pet02: Creation complete after 0s [id=relative-bengal]
random_pet.pet01: Creation complete after 0s [id=sterling-serval]
local_file.outro_arquivo: Creating...
local_file.arquivo: Creating...
local_file.outro_arquivo: Creation complete after 0s [id=10bf7381f9437662807187e63296b50af4485a6e]
local_file.arquivo: Creation complete after 0s [id=925813f181cb3610a0d6de0636852379dec64f52]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$

~~~~



- Gerou os 2 arquivos
devops-pro-terraform/terraform-modules/001-materiais/arquivo.txt
devops-pro-terraform/terraform-modules/001-materiais/outro_arquivo.txt














# Modularizando

- Primeiro vamos destruir a estrutura que criamos antes.

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ terraform destroy -auto-approve
random_pet.pet02: Refreshing state... [id=relative-bengal]
random_pet.pet01: Refreshing state... [id=sterling-serval]
local_file.arquivo: Refreshing state... [id=925813f181cb3610a0d6de0636852379dec64f52]
local_file.outro_arquivo: Refreshing state... [id=10bf7381f9437662807187e63296b50af4485a6e]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # local_file.arquivo will be destroyed
  - resource "local_file" "arquivo" {
      - content              = "sterling-serval" -> null
      - content_base64sha256 = "mC9nOB22xOJGBAwQSbxZA/Q2EiiV8rrEkjM+ES5eRCo=" -> null
      - content_base64sha512 = "z3Onqmf0zWNcxxhoSbvRCAnpxm8es++EqOJWkHfSaptXteZUq0M6a/2I96poMc+SZgjTB6Qb7v5TVk1GXPWrxw==" -> null
      - content_md5          = "6bf9679f284bdcb09fe114edb4ac3795" -> null
      - content_sha1         = "925813f181cb3610a0d6de0636852379dec64f52" -> null
      - content_sha256       = "982f67381db6c4e246040c1049bc5903f436122895f2bac492333e112e5e442a" -> null
      - content_sha512       = "cf73a7aa67f4cd635cc7186849bbd10809e9c66f1eb3ef84a8e2569077d26a9b57b5e654ab433a6bfd88f7aa6831cf926608d307a41beefe53564d465cf5abc7" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "arquivo.txt" -> null
      - id                   = "925813f181cb3610a0d6de0636852379dec64f52" -> null
    }

  # local_file.outro_arquivo will be destroyed
  - resource "local_file" "outro_arquivo" {
      - content              = "relative-bengal" -> null
      - content_base64sha256 = "V8tQxYNJ0aGwZkH9TWVsThPvXn8MmDEHCwabrPRlDeo=" -> null
      - content_base64sha512 = "hkzPITQlq9BtKhqMuGKbWw+0Io0s2/gPsjQXoD3Pha52kQPfz0IA3+Y6EZJRBlROZscvEnFIleWjryPr/JMR/A==" -> null
      - content_md5          = "f1e42c9fb9805c7ed8c9b90f5b79bde1" -> null
      - content_sha1         = "10bf7381f9437662807187e63296b50af4485a6e" -> null
      - content_sha256       = "57cb50c58349d1a1b06641fd4d656c4e13ef5e7f0c9831070b069bacf4650dea" -> null
      - content_sha512       = "864ccf213425abd06d2a1a8cb8629b5b0fb4228d2cdbf80fb23417a03dcf85ae769103dfcf4200dfe63a11925106544e66c72f12714895e5a3af23ebfc9311fc" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "outro_arquivo.txt" -> null
      - id                   = "10bf7381f9437662807187e63296b50af4485a6e" -> null
    }

  # random_pet.pet01 will be destroyed
  - resource "random_pet" "pet01" {
      - id        = "sterling-serval" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # random_pet.pet02 will be destroyed
  - resource "random_pet" "pet02" {
      - id        = "relative-bengal" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

Plan: 0 to add, 0 to change, 4 to destroy.
local_file.outro_arquivo: Destroying... [id=10bf7381f9437662807187e63296b50af4485a6e]
local_file.arquivo: Destroying... [id=925813f181cb3610a0d6de0636852379dec64f52]
local_file.arquivo: Destruction complete after 0s
local_file.outro_arquivo: Destruction complete after 0s
random_pet.pet02: Destroying... [id=relative-bengal]
random_pet.pet01: Destroying... [id=sterling-serval]
random_pet.pet02: Destruction complete after 0s
random_pet.pet01: Destruction complete after 0s

Destroy complete! Resources: 4 destroyed.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$

~~~~







- Criar um diretório chamado "modules" e uma pasta chamada "pets" dentro desta pasta:

~~~~bash
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ ls
main.tf  terraform.tfstate  terraform.tfstate.backup
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ mkdir modules
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ ls
main.tf  modules  terraform.tfstate  terraform.tfstate.backup
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ ls -lhasp
total 32K
4.0K drwxr-xr-x 4 fernando fernando 4.0K Mar 24 22:28 ./
4.0K drwxr-xr-x 3 fernando fernando 4.0K Mar 24 22:05 ../
4.0K -rw-r--r-- 1 fernando fernando  275 Mar 24 22:06 main.tf
4.0K drwxr-xr-x 2 fernando fernando 4.0K Mar 24 22:28 modules/
4.0K drwxr-xr-x 3 fernando fernando 4.0K Mar 24 22:10 .terraform/
4.0K -rw-r--r-- 1 fernando fernando 2.2K Mar 24 22:10 .terraform.lock.hcl
4.0K -rw-r--r-- 1 fernando fernando  156 Mar 24 22:22 terraform.tfstate
4.0K -rw-r--r-- 1 fernando fernando 3.7K Mar 24 22:22 terraform.tfstate.backup
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ ls -lhasp modules/
total 12K
4.0K drwxr-xr-x 3 fernando fernando 4.0K Mar 24 22:44 ./
4.0K drwxr-xr-x 4 fernando fernando 4.0K Mar 24 22:28 ../
4.0K drwxr-xr-x 2 fernando fernando 4.0K Mar 24 22:44 pets/
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$

~~~~


- Criado o arquivo main.tf dentro da pasta "pets"
devops-pro-terraform/terraform-modules/001-materiais/modules/pets/main.tf

- Este módulo vai ser um módulo filho.


- Na raíz desta pasta, criar um novo main.tf
nele vamos declarar um bloco chamado pets
este arquivo main.tf na raíz é o "Root Module"












# Calling a Child Module

<https://developer.hashicorp.com/terraform/language/modules/syntax>

To call a module means to include the contents of that module into the configuration with specific values for its input variables. Modules are called from within other modules using module blocks:

module "servers" {
  source = "./app-cluster"

  servers = 5
}






- Chamando o módulo filho, a partir do Root Module na raíz da pasta:

devops-pro-terraform/terraform-modules/001-materiais/main.tf

~~~~h
module "pets" {
  source = "./modules/pets"
}
~~~~




- É necessário rodar o terraform init novamente:

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ terraform plan
╷
│ Error: Module not installed
│
│   on main.tf line 1:
│    1: module "pets" {
│
│ This module is not yet installed. Run "terraform init" to install all modules required by this configuration.
╵
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ terraform init
Initializing modules...
- pets in modules/pets

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
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$

~~~~





- Então é efetuado novo apply.
- O resultado é o mesmo, só que de uma forma mais simple, usando o módulo:

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.pets.local_file.arquivo will be created
  + resource "local_file" "arquivo" {
      + content              = (known after apply)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets.local_file.outro_arquivo will be created
  + resource "local_file" "outro_arquivo" {
      + content              = (known after apply)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets.random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets.random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

Plan: 4 to add, 0 to change, 0 to destroy.
module.pets.random_pet.pet01: Creating...
module.pets.random_pet.pet02: Creating...
module.pets.random_pet.pet02: Creation complete after 0s [id=massive-griffon]
module.pets.random_pet.pet01: Creation complete after 0s [id=innocent-whippet]
module.pets.local_file.outro_arquivo: Creating...
module.pets.local_file.arquivo: Creating...
module.pets.local_file.outro_arquivo: Creation complete after 0s [id=04cf82acb73c1475ba61fa8b018d968dda109817]
module.pets.local_file.arquivo: Creation complete after 0s [id=a133be64471de9e6a21d125b8ba5aaac0f085c1d]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/001-materiais$

~~~~