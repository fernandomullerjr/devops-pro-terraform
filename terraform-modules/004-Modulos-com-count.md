

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
git commit -m "Terraform Modules - 004 Módulos com count."
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

# Módulos com count


- Iniciar destruindo arquivos gerados na última aula:
terraform destroy -auto-approve

~~~~bash
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform destroy -auto-approve
module.pets02.random_pet.pet01: Refreshing state... [id=wise-turkey]
module.pets02.random_pet.pet02: Refreshing state... [id=fast-toucan]

Plan: 0 to add, 0 to change, 8 to destroy.

Changes to Outputs:
  - nome_pet01 = "model-meerkat" -> null
  - nome_pet02 = "fast-toucan" -> null
module.pets01.local_file.arquivo: Destroying... [id=2a1f056f2b0ff4a07fd17fc4d8f9a37f19906c66]
module.pets01.local_file.outro_arquivo: Destroying... [id=86480ebc66ad7be6543095779349db736f8c98ea]
module.pets01.local_file.outro_arquivo: Destruction complete after 0s
module.pets01.local_file.arquivo: Destruction complete after 0s
module.pets01.random_pet.pet02: Destroying... [id=warm-osprey]
module.pets01.random_pet.pet02: Destruction complete after 0s
module.pets01.random_pet.pet01: Destroying... [id=model-meerkat]
module.pets01.random_pet.pet01: Destruction complete after 0s
module.pets02.local_file.outro_arquivo: Destroying... [id=b7d61c1bab5b2dcb36263d6f4f0107ad79e9d1ce]
module.pets02.local_file.arquivo: Destroying... [id=5a57fc8a5159cb2186f729d8b072ab34e4fa3ebc]
module.pets02.local_file.arquivo: Destruction complete after 0s
module.pets02.local_file.outro_arquivo: Destruction complete after 0s
module.pets02.random_pet.pet01: Destroying... [id=wise-turkey]
module.pets02.random_pet.pet01: Destruction complete after 0s
module.pets02.random_pet.pet02: Destroying... [id=fast-toucan]
module.pets02.random_pet.pet02: Destruction complete after 0s

Destroy complete! Resources: 8 destroyed.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$
~~~~






## Terraform - Count

https://developer.hashicorp.com/terraform/language/meta-arguments/count
<https://developer.hashicorp.com/terraform/language/meta-arguments/count>

### Basic Syntax

count is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type.

The count meta-argument accepts a whole number, and creates that many instances of the resource or module. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

~~~~h
resource "aws_instance" "server" {
  count = 4 # create four similar EC2 instances

  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

  tags = {
    Name = "Server ${count.index}"
  }
}
~~~~

### The count Object

In blocks where count is set, an additional count object is available in expressions, so you can modify the configuration of each instance. This object has one attribute:

    count.index — The distinct index number (starting with 0) corresponding to this instance.







- Ao invés de usar um manifesto assim, para criar vários recursos:

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



- E outputs assim:

~~~~h
output "nome_pet01" {
  value = module.pets01.nome_01
}

output "nome_pet02" {
  value = module.pets02.nome_02
}
~~~~











- Podemos usar o Count, desta maneira:
vamos modificar o nome do módulo, deixando apenas "pets" mesmo
adicionar o count, com a quantidade de vezes que queremos
usar o count.index para gerar 

~~~~h
module "pets" {
  source          = "./modules/pets"
  prefixo_arquivo = "teste-arquivo-${count.index}"
  count = 4
}

~~~~


- Já os Outputs, podemos chamar eles usando o asterisco:

~~~~h
output "nome_pet01" {
  value = module.pets[*].nome_01
}

output "nome_pet02" {
  value = module.pets[*].nome_02
}
~~~~



- Aplicando
terraform apply -auto-approve


- Aplicado:

~~~~bash

module.pets[2].local_file.outro_arquivo: Creation complete after 0s [id=90275ddbbecce2aea76a40a6a400f5f0055f23d2]
module.pets[0].local_file.outro_arquivo: Creation complete after 0s [id=7baad0cbf3c7571dc70bfc46a48fa5d13b39adbd]
module.pets[3].local_file.arquivo: Creation complete after 0s [id=10032508bfbd9260b942b9c74021119d56e4839f]

Apply complete! Resources: 16 added, 0 changed, 0 destroyed.

Outputs:

nome_pet01 = [
  "fluent-crow",
  "cheerful-airedale",
  "engaged-emu",
  "exotic-lark",
]
nome_pet02 = [
  "suited-magpie",
  "key-glowworm",
  "humane-filly",
  "quality-colt",
]
~~~~








### For-each

- Adaptando o código, mudando de count para for

module "pets" {
  source          = "./modules/pets"
  prefixo_arquivo = "teste-arquivo-${count.index}"
  count = 4
}
