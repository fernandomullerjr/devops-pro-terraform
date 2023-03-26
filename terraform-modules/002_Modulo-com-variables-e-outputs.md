
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
git commit -m "Terraform Modules - 002 Módulo com variables e outputs."
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

# Módulo com variables e outputs


- Criando arquivo contendo variáveis que serão utilizadas no módulo:

devops-pro-terraform/terraform-modules/002-materiais/modules/pets/variables.tf

~~~~h
variable "prefixo_arquivo" {
  default = "lab-modulos-"
}
~~~~




- Dizendo para o main.tf do módulo filho que ele vai usar variáveis interpoladas em alguns campos:

devops-pro-terraform/terraform-modules/002-materiais/modules/pets/main.tf

~~~~h
resource "local_file" "arquivo" {
  content  = random_pet.pet01.id
  filename = "${var.prefixo_arquivo}-arquivo.txt"
}

resource "local_file" "outro_arquivo" {
  content  = random_pet.pet02.id
  filename = "${var.prefixo_arquivo}-outro_arquivo.txt"
}

resource "random_pet" "pet01" {
}


resource "random_pet" "pet02" {
}
~~~~



- Definindo um valor personalizado para a variável "prefixo_arquivo", ao invés de usar o valor default dela:

devops-pro-terraform/terraform-modules/002-materiais/main.tf

~~~~h
module "pets" {
  source = "./modules/pets"
  prefixo_arquivo = "testando-prefixo-"
}
~~~~







- Efetuando plan:

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform plan
module.pets.random_pet.pet02: Refreshing state... [id=massive-griffon]
module.pets.random_pet.pet01: Refreshing state... [id=innocent-whippet]
module.pets.local_file.outro_arquivo: Refreshing state... [id=04cf82acb73c1475ba61fa8b018d968dda109817]
module.pets.local_file.arquivo: Refreshing state... [id=a133be64471de9e6a21d125b8ba5aaac0f085c1d]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # module.pets.local_file.arquivo must be replaced
-/+ resource "local_file" "arquivo" {
      ~ content_base64sha256 = "Vgk5V++wHO3H6cjFYKa3DnQcXhSg4vlW7lKDZbm0vEc=" -> (known after apply)
      ~ content_base64sha512 = "F/XYxEaR3CeRqCRbhBPQVm8qpNLdX/8w8zI785e+4UP+w8vv7igUOOtDlGpwosszvpxD8RLssLsu1MycFPR5Ig==" -> (known after apply)
      ~ content_md5          = "01cd6c78dba23396d2e9565da304654e" -> (known after apply)
      ~ content_sha1         = "a133be64471de9e6a21d125b8ba5aaac0f085c1d" -> (known after apply)
      ~ content_sha256       = "56093957efb01cedc7e9c8c560a6b70e741c5e14a0e2f956ee528365b9b4bc47" -> (known after apply)
      ~ content_sha512       = "17f5d8c44691dc2791a8245b8413d0566f2aa4d2dd5fff30f3323bf397bee143fec3cbefee281438eb43946a70a2cb33be9c43f112ecb0bb2ed4cc9c14f47922" -> (known after apply)
      ~ filename             = "arquivo.txt" -> "testando-prefixo--arquivo.txt" # forces replacement
      ~ id                   = "a133be64471de9e6a21d125b8ba5aaac0f085c1d" -> (known after apply)
        # (3 unchanged attributes hidden)
    }

  # module.pets.local_file.outro_arquivo must be replaced
-/+ resource "local_file" "outro_arquivo" {
      ~ content_base64sha256 = "kY/KD8SjP1ZCh42NwLFMsUwGNWE9KMkvoZhCc3xBh54=" -> (known after apply)
      ~ content_base64sha512 = "BWBq1EMYVw2LxFQQ9X/qdIz5MuihdFIJMsevFY4hRWnpSP4MwBGMODMNWMEqGw44ig+0//kKCUwfHm1TjQMg6A==" -> (known after apply)
      ~ content_md5          = "d06afb3f07b1207d801b0c582b752787" -> (known after apply)
      ~ content_sha1         = "04cf82acb73c1475ba61fa8b018d968dda109817" -> (known after apply)
      ~ content_sha256       = "918fca0fc4a33f5642878d8dc0b14cb14c0635613d28c92fa19842737c41879e" -> (known after apply)
      ~ content_sha512       = "05606ad44318570d8bc45410f57fea748cf932e8a174520932c7af158e214569e948fe0cc0118c38330d58c12a1b0e388a0fb4fff90a094c1f1e6d538d0320e8" -> (known after apply)
      ~ filename             = "outro_arquivo.txt" -> "testando-prefixo--outro_arquivo.txt" # forces replacement
      ~ id                   = "04cf82acb73c1475ba61fa8b018d968dda109817" -> (known after apply)
        # (3 unchanged attributes hidden)
    }

Plan: 2 to add, 0 to change, 2 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$

~~~~









- Efetuando apply:

terraform apply -auto-approve


terraform apply -auto-approve

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform apply -auto-approve
module.pets.random_pet.pet01: Refreshing state... [id=innocent-whippet]
module.pets.random_pet.pet02: Refreshing state... [id=massive-griffon]
module.pets.local_file.outro_arquivo: Refreshing state... [id=04cf82acb73c1475ba61fa8b018d968dda109817]
module.pets.local_file.arquivo: Refreshing state... [id=a133be64471de9e6a21d125b8ba5aaac0f085c1d]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # module.pets.local_file.arquivo must be replaced
-/+ resource "local_file" "arquivo" {
      ~ content_base64sha256 = "Vgk5V++wHO3H6cjFYKa3DnQcXhSg4vlW7lKDZbm0vEc=" -> (known after apply)
      ~ content_base64sha512 = "F/XYxEaR3CeRqCRbhBPQVm8qpNLdX/8w8zI785e+4UP+w8vv7igUOOtDlGpwosszvpxD8RLssLsu1MycFPR5Ig==" -> (known after apply)
      ~ content_md5          = "01cd6c78dba23396d2e9565da304654e" -> (known after apply)
      ~ content_sha1         = "a133be64471de9e6a21d125b8ba5aaac0f085c1d" -> (known after apply)
      ~ content_sha256       = "56093957efb01cedc7e9c8c560a6b70e741c5e14a0e2f956ee528365b9b4bc47" -> (known after apply)
      ~ content_sha512       = "17f5d8c44691dc2791a8245b8413d0566f2aa4d2dd5fff30f3323bf397bee143fec3cbefee281438eb43946a70a2cb33be9c43f112ecb0bb2ed4cc9c14f47922" -> (known after apply)
      ~ filename             = "arquivo.txt" -> "testando-prefixo--arquivo.txt" # forces replacement
      ~ id                   = "a133be64471de9e6a21d125b8ba5aaac0f085c1d" -> (known after apply)
        # (3 unchanged attributes hidden)
    }

  # module.pets.local_file.outro_arquivo must be replaced
-/+ resource "local_file" "outro_arquivo" {
      ~ content_base64sha256 = "kY/KD8SjP1ZCh42NwLFMsUwGNWE9KMkvoZhCc3xBh54=" -> (known after apply)
      ~ content_base64sha512 = "BWBq1EMYVw2LxFQQ9X/qdIz5MuihdFIJMsevFY4hRWnpSP4MwBGMODMNWMEqGw44ig+0//kKCUwfHm1TjQMg6A==" -> (known after apply)
      ~ content_md5          = "d06afb3f07b1207d801b0c582b752787" -> (known after apply)
      ~ content_sha1         = "04cf82acb73c1475ba61fa8b018d968dda109817" -> (known after apply)
      ~ content_sha256       = "918fca0fc4a33f5642878d8dc0b14cb14c0635613d28c92fa19842737c41879e" -> (known after apply)
      ~ content_sha512       = "05606ad44318570d8bc45410f57fea748cf932e8a174520932c7af158e214569e948fe0cc0118c38330d58c12a1b0e388a0fb4fff90a094c1f1e6d538d0320e8" -> (known after apply)
      ~ filename             = "outro_arquivo.txt" -> "testando-prefixo--outro_arquivo.txt" # forces replacement
      ~ id                   = "04cf82acb73c1475ba61fa8b018d968dda109817" -> (known after apply)
        # (3 unchanged attributes hidden)
    }

Plan: 2 to add, 0 to change, 2 to destroy.
module.pets.local_file.arquivo: Destroying... [id=a133be64471de9e6a21d125b8ba5aaac0f085c1d]
module.pets.local_file.outro_arquivo: Destroying... [id=04cf82acb73c1475ba61fa8b018d968dda109817]
module.pets.local_file.arquivo: Destruction complete after 0s
module.pets.local_file.outro_arquivo: Destruction complete after 0s
module.pets.local_file.outro_arquivo: Creating...
module.pets.local_file.arquivo: Creating...
module.pets.local_file.outro_arquivo: Creation complete after 0s [id=04cf82acb73c1475ba61fa8b018d968dda109817]
module.pets.local_file.arquivo: Creation complete after 0s [id=a133be64471de9e6a21d125b8ba5aaac0f085c1d]

Apply complete! Resources: 2 added, 0 changed, 2 destroyed.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$

~~~~










- Efetuou a mudança do nome dos arquivos, conforme:
devops-pro-terraform/terraform-modules/002-materiais/testando-prefixo--arquivo.txt
devops-pro-terraform/terraform-modules/002-materiais/testando-prefixo--outro_arquivo.txt

- Obedecendo o valor que foi definido no manifesto main.tf do Root Module:
devops-pro-terraform/terraform-modules/002-materiais/main.tf










----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

# Outputs

devops-pro-terraform/terraform-modules/002-materiais/modules/pets/outputs.tf

~~~~h
output "nome_01" {
  value = random_pet.pet01.id
}

output "nome_02" {
  value = random_pet.pet02.id
}
~~~~


- Não traz

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform apply -auto-approve
module.pets.random_pet.pet02: Refreshing state... [id=massive-griffon]
module.pets.random_pet.pet01: Refreshing state... [id=innocent-whippet]
module.pets.local_file.outro_arquivo: Refreshing state... [id=04cf82acb73c1475ba61fa8b018d968dda109817]
module.pets.local_file.arquivo: Refreshing state... [id=a133be64471de9e6a21d125b8ba5aaac0f085c1d]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$

~~~~







- É necessário criar um outputs.tf na raíz do módulo também.
Este outputs vai referenciar o módulo filho

~~~~h
output "nome_pet01" {
  value = module.pets.nome_01
}

output "nome_pet02" {
  value = module.pets.nome_02
}
~~~~



- Testando novamente

terraform apply -auto-approve

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform apply -auto-approve
module.pets.random_pet.pet02: Refreshing state... [id=massive-griffon]
module.pets.random_pet.pet01: Refreshing state... [id=innocent-whippet]
module.pets.local_file.outro_arquivo: Refreshing state... [id=04cf82acb73c1475ba61fa8b018d968dda109817]
module.pets.local_file.arquivo: Refreshing state... [id=a133be64471de9e6a21d125b8ba5aaac0f085c1d]

Changes to Outputs:
  ~ nome_pet01 = {
      - id        = "innocent-whippet"
      - keepers   = null
      - length    = 2
      - prefix    = null
      - separator = "-"
    } -> "innocent-whippet"
  ~ nome_pet02 = {
      - id        = "massive-griffon"
      - keepers   = null
      - length    = 2
      - prefix    = null
      - separator = "-"
    } -> "massive-griffon"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

nome_pet01 = "innocent-whippet"
nome_pet02 = "massive-griffon"
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$

~~~~







- Desta maneira foi possível obter os valores do output do módulo filho, através do módulo raíz.