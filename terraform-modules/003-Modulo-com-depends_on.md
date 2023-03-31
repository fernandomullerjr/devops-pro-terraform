


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





- Necessário efetuar init e plan novamente:

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


fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform plan
module.pets.random_pet.pet02: Refreshing state... [id=massive-griffon]
module.pets.local_file.outro_arquivo: Refreshing state... [id=04cf82acb73c1475ba61fa8b018d968dda109817]
module.pets.random_pet.pet01: Refreshing state... [id=innocent-whippet]
module.pets.local_file.arquivo: Refreshing state... [id=a133be64471de9e6a21d125b8ba5aaac0f085c1d]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
  - destroy

Terraform will perform the following actions:

  # module.pets.local_file.arquivo will be destroyed
  # (because local_file.arquivo is not in configuration)
  - resource "local_file" "arquivo" {
      - content              = "innocent-whippet" -> null
      - content_base64sha256 = "Vgk5V++wHO3H6cjFYKa3DnQcXhSg4vlW7lKDZbm0vEc=" -> null
      - content_base64sha512 = "F/XYxEaR3CeRqCRbhBPQVm8qpNLdX/8w8zI785e+4UP+w8vv7igUOOtDlGpwosszvpxD8RLssLsu1MycFPR5Ig==" -> null
      - content_md5          = "01cd6c78dba23396d2e9565da304654e" -> null
      - content_sha1         = "a133be64471de9e6a21d125b8ba5aaac0f085c1d" -> null
      - content_sha256       = "56093957efb01cedc7e9c8c560a6b70e741c5e14a0e2f956ee528365b9b4bc47" -> null
      - content_sha512       = "17f5d8c44691dc2791a8245b8413d0566f2aa4d2dd5fff30f3323bf397bee143fec3cbefee281438eb43946a70a2cb33be9c43f112ecb0bb2ed4cc9c14f47922" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "testando-prefixo--arquivo.txt" -> null
      - id                   = "a133be64471de9e6a21d125b8ba5aaac0f085c1d" -> null
    }

  # module.pets.local_file.outro_arquivo will be destroyed
  # (because local_file.outro_arquivo is not in configuration)
  - resource "local_file" "outro_arquivo" {
      - content              = "massive-griffon" -> null
      - content_base64sha256 = "kY/KD8SjP1ZCh42NwLFMsUwGNWE9KMkvoZhCc3xBh54=" -> null
      - content_base64sha512 = "BWBq1EMYVw2LxFQQ9X/qdIz5MuihdFIJMsevFY4hRWnpSP4MwBGMODMNWMEqGw44ig+0//kKCUwfHm1TjQMg6A==" -> null
      - content_md5          = "d06afb3f07b1207d801b0c582b752787" -> null
      - content_sha1         = "04cf82acb73c1475ba61fa8b018d968dda109817" -> null
      - content_sha256       = "918fca0fc4a33f5642878d8dc0b14cb14c0635613d28c92fa19842737c41879e" -> null
      - content_sha512       = "05606ad44318570d8bc45410f57fea748cf932e8a174520932c7af158e214569e948fe0cc0118c38330d58c12a1b0e388a0fb4fff90a094c1f1e6d538d0320e8" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "testando-prefixo--outro_arquivo.txt" -> null
      - id                   = "04cf82acb73c1475ba61fa8b018d968dda109817" -> null
    }

  # module.pets.random_pet.pet01 will be destroyed
  # (because random_pet.pet01 is not in configuration)
  - resource "random_pet" "pet01" {
      - id        = "innocent-whippet" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets.random_pet.pet02 will be destroyed
  # (because random_pet.pet02 is not in configuration)
  - resource "random_pet" "pet02" {
      - id        = "massive-griffon" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets01.local_file.arquivo will be created
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
      + filename             = "teste-arquivo-01-arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets01.local_file.outro_arquivo will be created
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
      + filename             = "teste-arquivo-01-outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets01.random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets01.random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets02.local_file.arquivo will be created
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
      + filename             = "teste-arquivo-02-arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets02.local_file.outro_arquivo will be created
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
      + filename             = "teste-arquivo-02-outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets02.random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets02.random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

Plan: 8 to add, 0 to change, 4 to destroy.

Changes to Outputs:
  ~ nome_pet01 = "innocent-whippet" -> (known after apply)
  ~ nome_pet02 = "massive-griffon" -> (known after apply)

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$

~~~~













- Aplicando:

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform apply -auto-approve
module.pets.random_pet.pet02: Refreshing state... [id=massive-griffon]
module.pets.random_pet.pet01: Refreshing state... [id=innocent-whippet]
module.pets.local_file.outro_arquivo: Refreshing state... [id=04cf82acb73c1475ba61fa8b018d968dda109817]
module.pets.local_file.arquivo: Refreshing state... [id=a133be64471de9e6a21d125b8ba5aaac0f085c1d]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
  - destroy

Terraform will perform the following actions:

  # module.pets.local_file.arquivo will be destroyed
  # (because local_file.arquivo is not in configuration)
  - resource "local_file" "arquivo" {
      - content              = "innocent-whippet" -> null
      - content_base64sha256 = "Vgk5V++wHO3H6cjFYKa3DnQcXhSg4vlW7lKDZbm0vEc=" -> null
      - content_base64sha512 = "F/XYxEaR3CeRqCRbhBPQVm8qpNLdX/8w8zI785e+4UP+w8vv7igUOOtDlGpwosszvpxD8RLssLsu1MycFPR5Ig==" -> null
      - content_md5          = "01cd6c78dba23396d2e9565da304654e" -> null
      - content_sha1         = "a133be64471de9e6a21d125b8ba5aaac0f085c1d" -> null
      - content_sha256       = "56093957efb01cedc7e9c8c560a6b70e741c5e14a0e2f956ee528365b9b4bc47" -> null
      - content_sha512       = "17f5d8c44691dc2791a8245b8413d0566f2aa4d2dd5fff30f3323bf397bee143fec3cbefee281438eb43946a70a2cb33be9c43f112ecb0bb2ed4cc9c14f47922" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "testando-prefixo--arquivo.txt" -> null
      - id                   = "a133be64471de9e6a21d125b8ba5aaac0f085c1d" -> null
    }

  # module.pets.local_file.outro_arquivo will be destroyed
  # (because local_file.outro_arquivo is not in configuration)
  - resource "local_file" "outro_arquivo" {
      - content              = "massive-griffon" -> null
      - content_base64sha256 = "kY/KD8SjP1ZCh42NwLFMsUwGNWE9KMkvoZhCc3xBh54=" -> null
      - content_base64sha512 = "BWBq1EMYVw2LxFQQ9X/qdIz5MuihdFIJMsevFY4hRWnpSP4MwBGMODMNWMEqGw44ig+0//kKCUwfHm1TjQMg6A==" -> null
      - content_md5          = "d06afb3f07b1207d801b0c582b752787" -> null
      - content_sha1         = "04cf82acb73c1475ba61fa8b018d968dda109817" -> null
      - content_sha256       = "918fca0fc4a33f5642878d8dc0b14cb14c0635613d28c92fa19842737c41879e" -> null
      - content_sha512       = "05606ad44318570d8bc45410f57fea748cf932e8a174520932c7af158e214569e948fe0cc0118c38330d58c12a1b0e388a0fb4fff90a094c1f1e6d538d0320e8" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "testando-prefixo--outro_arquivo.txt" -> null
      - id                   = "04cf82acb73c1475ba61fa8b018d968dda109817" -> null
    }

  # module.pets.random_pet.pet01 will be destroyed
  # (because random_pet.pet01 is not in configuration)
  - resource "random_pet" "pet01" {
      - id        = "innocent-whippet" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets.random_pet.pet02 will be destroyed
  # (because random_pet.pet02 is not in configuration)
  - resource "random_pet" "pet02" {
      - id        = "massive-griffon" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets01.local_file.arquivo will be created
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
      + filename             = "teste-arquivo-01-arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets01.local_file.outro_arquivo will be created
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
      + filename             = "teste-arquivo-01-outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets01.random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets01.random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets02.local_file.arquivo will be created
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
      + filename             = "teste-arquivo-02-arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets02.local_file.outro_arquivo will be created
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
      + filename             = "teste-arquivo-02-outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets02.random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets02.random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

Plan: 8 to add, 0 to change, 4 to destroy.

Changes to Outputs:
  ~ nome_pet01 = "innocent-whippet" -> (known after apply)
  ~ nome_pet02 = "massive-griffon" -> (known after apply)
module.pets.local_file.arquivo: Destroying... [id=a133be64471de9e6a21d125b8ba5aaac0f085c1d]
module.pets.local_file.outro_arquivo: Destroying... [id=04cf82acb73c1475ba61fa8b018d968dda109817]
module.pets.local_file.arquivo: Destruction complete after 0s
module.pets.local_file.outro_arquivo: Destruction complete after 0s
module.pets02.random_pet.pet01: Creating...
module.pets01.random_pet.pet01: Creating...
module.pets01.random_pet.pet02: Creating...
module.pets.random_pet.pet01: Destroying... [id=innocent-whippet]
module.pets.random_pet.pet02: Destroying... [id=massive-griffon]
module.pets02.random_pet.pet02: Creating...
module.pets02.random_pet.pet01: Creation complete after 0s [id=selected-titmouse]
module.pets.random_pet.pet01: Destruction complete after 0s
module.pets.random_pet.pet02: Destruction complete after 0s
module.pets01.random_pet.pet01: Creation complete after 0s [id=main-mule]
module.pets02.random_pet.pet02: Creation complete after 0s [id=definite-marten]
module.pets01.random_pet.pet02: Creation complete after 0s [id=central-malamute]
module.pets02.local_file.arquivo: Creating...
module.pets01.local_file.arquivo: Creating...
module.pets02.local_file.arquivo: Creation complete after 1s [id=ac41472414dc984fef44b6bce794a6bcc7d9ce9f]
module.pets02.local_file.outro_arquivo: Creating...
module.pets01.local_file.arquivo: Creation complete after 0s [id=fc58b3d38e4e93101abb52434f4bd879cf8f230f]
module.pets02.local_file.outro_arquivo: Creation complete after 0s [id=5d96711cb7829989607c8346e629421eea943114]
module.pets01.local_file.outro_arquivo: Creating...
module.pets01.local_file.outro_arquivo: Creation complete after 0s [id=60dfd0ea3fc1e5fe222cc2fb2bad93c7bf2476d7]

Apply complete! Resources: 8 added, 0 changed, 4 destroyed.

Outputs:

nome_pet01 = "main-mule"
nome_pet02 = "definite-marten"
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$

~~~~













- Agora temos 4 arquivos gerados, sendo mais simples multiplicar o módulo que já está pronto, ao invés de copiar todos os manifestos envolvidos na criação da estrutura desejada(vários manifestos, as vezes):

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ ls
main.tf  outputs.tf         terraform.tfstate.backup      teste-arquivo-01-outro_arquivo.txt  teste-arquivo-02-outro_arquivo.txt
modules  terraform.tfstate  teste-arquivo-01-arquivo.txt  teste-arquivo-02-arquivo.txt
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ ls -lhasp
total 60K
4.0K drwxr-xr-x 4 fernando fernando 4.0K Mar 29 20:48 ./
4.0K drwxr-xr-x 4 fernando fernando 4.0K Mar 29 19:59 ../
4.0K -rw-r--r-- 1 fernando fernando  193 Mar 29 20:44 main.tf
4.0K drwxr-xr-x 3 fernando fernando 4.0K Mar 25 21:20 modules/
4.0K -rw-r--r-- 1 fernando fernando  112 Mar 29 20:45 outputs.tf
4.0K drwxr-xr-x 4 fernando fernando 4.0K Mar 25 21:20 .terraform/
4.0K -rw-r--r-- 1 fernando fernando 2.2K Mar 25 21:20 .terraform.lock.hcl
8.0K -rw-r--r-- 1 fernando fernando 7.8K Mar 29 20:48 terraform.tfstate
8.0K -rw-r--r-- 1 fernando fernando 4.1K Mar 29 20:48 terraform.tfstate.backup
4.0K -rwxr-xr-x 1 fernando fernando    9 Mar 29 20:48 teste-arquivo-01-arquivo.txt
4.0K -rwxr-xr-x 1 fernando fernando   16 Mar 29 20:48 teste-arquivo-01-outro_arquivo.txt
4.0K -rwxr-xr-x 1 fernando fernando   17 Mar 29 20:48 teste-arquivo-02-arquivo.txt
4.0K -rwxr-xr-x 1 fernando fernando   15 Mar 29 20:48 teste-arquivo-02-outro_arquivo.txt
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$

~~~~










- Analisando as saaídas dos comandos, o pet01 é criado antes do pet02:

module.pets02.random_pet.pet01: Creating...
module.pets01.random_pet.pet01: Creating...
module.pets01.random_pet.pet02: Creating...
module.pets.random_pet.pet01: Destroying... [id=innocent-whippet]
module.pets.random_pet.pet02: Destroying... [id=massive-griffon]
module.pets02.random_pet.pet02: Creating...


- Vamos ajustar para que o pet01 seja criado depois do pet02, apenas para fins de teste.

adicionar o   depends_on


- Ficando assim o manifesto:

~~~~h
module "pets01" {
  source          = "./modules/pets"
  prefixo_arquivo = "teste-arquivo-01"
  
  depends_on = [
    module.pets02
  ]
}

module "pets02" {
  source          = "./modules/pets"
  prefixo_arquivo = "teste-arquivo-02"
}

~~~~


- Efetuando novo apply:

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.pets01.local_file.arquivo will be created
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
      + filename             = "teste-arquivo-01-arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets01.local_file.outro_arquivo will be created
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
      + filename             = "teste-arquivo-01-outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets01.random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets01.random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets02.local_file.arquivo will be created
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
      + filename             = "teste-arquivo-02-arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets02.local_file.outro_arquivo will be created
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
      + filename             = "teste-arquivo-02-outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets02.random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets02.random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

Plan: 8 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + nome_pet01 = (known after apply)
  + nome_pet02 = (known after apply)
module.pets02.random_pet.pet02: Creating...
module.pets02.random_pet.pet01: Creating...
module.pets02.random_pet.pet02: Creation complete after 0s [id=fast-toucan]
module.pets02.random_pet.pet01: Creation complete after 0s [id=wise-turkey]
module.pets02.local_file.arquivo: Creating...
module.pets02.local_file.outro_arquivo: Creating...
module.pets02.local_file.arquivo: Creation complete after 0s [id=5a57fc8a5159cb2186f729d8b072ab34e4fa3ebc]
module.pets02.local_file.outro_arquivo: Creation complete after 0s [id=b7d61c1bab5b2dcb36263d6f4f0107ad79e9d1ce]
module.pets01.random_pet.pet01: Creating...
module.pets01.random_pet.pet02: Creating...
module.pets01.random_pet.pet01: Creation complete after 0s [id=model-meerkat]
module.pets01.random_pet.pet02: Creation complete after 0s [id=warm-osprey]
module.pets01.local_file.arquivo: Creating...
module.pets01.local_file.outro_arquivo: Creating...
module.pets01.local_file.arquivo: Creation complete after 0s [id=2a1f056f2b0ff4a07fd17fc4d8f9a37f19906c66]
module.pets01.local_file.outro_arquivo: Creation complete after 0s [id=86480ebc66ad7be6543095779349db736f8c98ea]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

nome_pet01 = "model-meerkat"
nome_pet02 = "fast-toucan"
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$

~~~~


- Agora é possível verificar que o pet02 é criado antes do pet01:

module.pets02.random_pet.pet02: Creating...
module.pets02.random_pet.pet01: Creating...