


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
git commit -m "Projeto - eks-via-terraform-github-actions"
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