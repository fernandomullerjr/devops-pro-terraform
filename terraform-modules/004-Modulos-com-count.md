

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


- Observação:
para esta aula, foram usados os manifestos da pasta:
devops-pro-terraform/terraform-modules/002-materiais

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

- Adaptando o código, mudando de count para for_each:

~~~~h
module "pets" {
  source          = "./modules/pets"
  prefixo_arquivo = "teste-arquivo-${each.key}"
  for_each = ["pre01", "pre02", "pre03", "pre04"]
}
~~~~


- Outputs:

~~~~h
output "nome_pet01" {
  value = module.pets[*]
}

output "nome_pet02" {
  value = module.pets[*]
}
~~~~



- Assim deu erro:

~~~~bash
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform plan
╷
│ Error: Invalid for_each argument
│
│   on main.tf line 4, in module "pets":
│    4:   for_each = ["pre01", "pre02", "pre03", "pre04"]
│
│ The given "for_each" argument value is unsuitable: the "for_each" argument must be a map, or set of strings, and you have provided a value of type tuple.
╵
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$

~~~~






### Função toset

Examples

> toset(["a", "b", "c"])
[
  "a",
  "b",
  "c",
]


- Usando a função toset, para transformar os valores para o tipo set:

~~~~h
module "pets" {
  source          = "./modules/pets"
  prefixo_arquivo = "teste-arquivo-${each.key}"
  for_each = toset( ["pre01", "pre02", "pre03", "pre04"] )
}

~~~~




- Aplicando:

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$ terraform apply -auto-approve
module.pets[0].random_pet.pet02: Refreshing state... [id=suited-magpie]
module.pets[1].random_pet.pet01: Refreshing state... [id=cheerful-airedale]
module.pets[1].random_pet.pet02: Refreshing state... [id=key-glowworm]
module.pets[2].random_pet.pet02: Refreshing state... [id=humane-filly]
module.pets[3].random_pet.pet02: Refreshing state... [id=quality-colt]
module.pets[2].random_pet.pet01: Refreshing state... [id=engaged-emu]
module.pets[0].random_pet.pet01: Refreshing state... [id=fluent-crow]
module.pets[3].random_pet.pet01: Refreshing state... [id=exotic-lark]
module.pets[0].local_file.outro_arquivo: Refreshing state... [id=7baad0cbf3c7571dc70bfc46a48fa5d13b39adbd]
module.pets[1].local_file.outro_arquivo: Refreshing state... [id=e3de02328e9be0b15ed3502fd52e5400c561f096]
module.pets[3].local_file.outro_arquivo: Refreshing state... [id=bec6e266786a5af65846af76737bcdb208078028]
module.pets[2].local_file.outro_arquivo: Refreshing state... [id=90275ddbbecce2aea76a40a6a400f5f0055f23d2]
module.pets[3].local_file.arquivo: Refreshing state... [id=10032508bfbd9260b942b9c74021119d56e4839f]
module.pets[0].local_file.arquivo: Refreshing state... [id=7bbfddfdd58c0b8933b4035e720f9102fbfb7c6c]
module.pets[1].local_file.arquivo: Refreshing state... [id=65bf2acbeb6f31e3c342e942596ad09689b5bf70]
module.pets[2].local_file.arquivo: Refreshing state... [id=dbf1350c5f63273ea7d6f5f7e190412a33b79536]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
  - destroy

Terraform will perform the following actions:

  # module.pets[0].local_file.arquivo will be destroyed
  # (because module.pets[0] is not in configuration)
  - resource "local_file" "arquivo" {
      - content              = "fluent-crow" -> null
      - content_base64sha256 = "wzhiM4Q3733bkOK3TelR9Fj10zz6hvWbifausxaigAg=" -> null
      - content_base64sha512 = "neKoirxIfU8Exq9zx4/Ep+vpdVYkQIMJhhlzZBkvIO/WhhSUp/r+YsTRYjZb+yFGEVSTD4gL4KJH+9gSfZ4MVg==" -> null
      - content_md5          = "8ac20d542c1c12adb792874dd5639839" -> null
      - content_sha1         = "7bbfddfdd58c0b8933b4035e720f9102fbfb7c6c" -> null
      - content_sha256       = "c33862338437ef7ddb90e2b74de951f458f5d33cfa86f59b89f6aeb316a28008" -> null
      - content_sha512       = "9de2a88abc487d4f04c6af73c78fc4a7ebe975562440830986197364192f20efd6861494a7fafe62c4d162365bfb21461154930f880be0a247fbd8127d9e0c56" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "teste-arquivo-0-arquivo.txt" -> null
      - id                   = "7bbfddfdd58c0b8933b4035e720f9102fbfb7c6c" -> null
    }

  # module.pets[0].local_file.outro_arquivo will be destroyed
  # (because module.pets[0] is not in configuration)
  - resource "local_file" "outro_arquivo" {
      - content              = "suited-magpie" -> null
      - content_base64sha256 = "MSXLzzF5/fpuB5Ux+YMQ1UBsh+2COxUt6pbkp4Kjjl4=" -> null
      - content_base64sha512 = "boaKKPMtLWFWCHdwLVM/ho4Zpr3q2KZbo2mcqJmU+8ZWtujU274zoe0eHTNVzFV7/ZmDLlo5lKVoHvsiUzj0TA==" -> null
      - content_md5          = "30b806d360cf2c82d9909a8d98413151" -> null
      - content_sha1         = "7baad0cbf3c7571dc70bfc46a48fa5d13b39adbd" -> null
      - content_sha256       = "3125cbcf3179fdfa6e079531f98310d5406c87ed823b152dea96e4a782a38e5e" -> null
      - content_sha512       = "6e868a28f32d2d61560877702d533f868e19a6bdead8a65ba3699ca89994fbc656b6e8d4dbbe33a1ed1e1d3355cc557bfd99832e5a3994a5681efb225338f44c" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "teste-arquivo-0-outro_arquivo.txt" -> null
      - id                   = "7baad0cbf3c7571dc70bfc46a48fa5d13b39adbd" -> null
    }

  # module.pets[0].random_pet.pet01 will be destroyed
  # (because module.pets[0] is not in configuration)
  - resource "random_pet" "pet01" {
      - id        = "fluent-crow" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets[0].random_pet.pet02 will be destroyed
  # (because module.pets[0] is not in configuration)
  - resource "random_pet" "pet02" {
      - id        = "suited-magpie" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets[1].local_file.arquivo will be destroyed
  # (because module.pets[1] is not in configuration)
  - resource "local_file" "arquivo" {
      - content              = "cheerful-airedale" -> null
      - content_base64sha256 = "xrRm2OCbfUkpBbgvGkfvVh5XP72HQD46aD3ddh8XdG4=" -> null
      - content_base64sha512 = "vaQzvi+ARyjJ/ZqfnfZtLltBfjZpHBT9tby3lAt5AdPZ60xqOTI6hBvvQJheO4jrp/BMJaaL1ZKUGgWP4a/5kA==" -> null
      - content_md5          = "5b437dbb57c8b37b79dd3575786c0026" -> null
      - content_sha1         = "65bf2acbeb6f31e3c342e942596ad09689b5bf70" -> null
      - content_sha256       = "c6b466d8e09b7d492905b82f1a47ef561e573fbd87403e3a683ddd761f17746e" -> null
      - content_sha512       = "bda433be2f804728c9fd9a9f9df66d2e5b417e36691c14fdb5bcb7940b7901d3d9eb4c6a39323a841bef40985e3b88eba7f04c25a68bd592941a058fe1aff990" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "teste-arquivo-1-arquivo.txt" -> null
      - id                   = "65bf2acbeb6f31e3c342e942596ad09689b5bf70" -> null
    }

  # module.pets[1].local_file.outro_arquivo will be destroyed
  # (because module.pets[1] is not in configuration)
  - resource "local_file" "outro_arquivo" {
      - content              = "key-glowworm" -> null
      - content_base64sha256 = "1sg7Aa6im4Q3WO1fRZsc1BQgJEjOs+Qhz8eWWHe4BTE=" -> null
      - content_base64sha512 = "V8ekKmQCTB9L49INCwi7PdYtL5QttNsUySYgVM+8cEDs+JADwZbexbxEzP10vE53SbGgZXgrJbSdOrovqBl3fQ==" -> null
      - content_md5          = "05713e05e66d9973eacf0e0c449de718" -> null
      - content_sha1         = "e3de02328e9be0b15ed3502fd52e5400c561f096" -> null
      - content_sha256       = "d6c83b01aea29b843758ed5f459b1cd414202448ceb3e421cfc7965877b80531" -> null
      - content_sha512       = "57c7a42a64024c1f4be3d20d0b08bb3dd62d2f942db4db14c9262054cfbc7040ecf89003c196dec5bc44ccfd74bc4e7749b1a065782b25b49d3aba2fa819777d" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "teste-arquivo-1-outro_arquivo.txt" -> null
      - id                   = "e3de02328e9be0b15ed3502fd52e5400c561f096" -> null
    }

  # module.pets[1].random_pet.pet01 will be destroyed
  # (because module.pets[1] is not in configuration)
  - resource "random_pet" "pet01" {
      - id        = "cheerful-airedale" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets[1].random_pet.pet02 will be destroyed
  # (because module.pets[1] is not in configuration)
  - resource "random_pet" "pet02" {
      - id        = "key-glowworm" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets[2].local_file.arquivo will be destroyed
  # (because module.pets[2] is not in configuration)
  - resource "local_file" "arquivo" {
      - content              = "engaged-emu" -> null
      - content_base64sha256 = "Tz1URzOWgrzNdwpV0MgKH8YqzReki0Q2sEBnRNM57z8=" -> null
      - content_base64sha512 = "w5fYrmdryKBHETDknMYLJjMm07qGN6FRnP9rejZ2UCGY1BqTISSxio5iBCfSiYKEMZwvxnWdGLuHhSWT66XhDg==" -> null
      - content_md5          = "5d09b7fc10c214db55eebb361dc46767" -> null
      - content_sha1         = "dbf1350c5f63273ea7d6f5f7e190412a33b79536" -> null
      - content_sha256       = "4f3d5447339682bccd770a55d0c80a1fc62acd17a48b4436b0406744d339ef3f" -> null
      - content_sha512       = "c397d8ae676bc8a0471130e49cc60b263326d3ba8637a1519cff6b7a3676502198d41a932124b18a8e620427d2898284319c2fc6759d18bb87852593eba5e10e" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "teste-arquivo-2-arquivo.txt" -> null
      - id                   = "dbf1350c5f63273ea7d6f5f7e190412a33b79536" -> null
    }

  # module.pets[2].local_file.outro_arquivo will be destroyed
  # (because module.pets[2] is not in configuration)
  - resource "local_file" "outro_arquivo" {
      - content              = "humane-filly" -> null
      - content_base64sha256 = "xndWZua0oTTMj89RrdKERoOET8vVD9eDjqN1DCjZ1bQ=" -> null
      - content_base64sha512 = "ggYGXWH0ftderD1nq510Cwvl8htLyGrxgwRancdFAR1U6UdnQlRdNgSEC2oyx3ZhjxoMENxFBlPF0lROq0zScw==" -> null
      - content_md5          = "322858ae777dc8957d048d535397307a" -> null
      - content_sha1         = "90275ddbbecce2aea76a40a6a400f5f0055f23d2" -> null
      - content_sha256       = "c6775666e6b4a134cc8fcf51add2844683844fcbd50fd7838ea3750c28d9d5b4" -> null
      - content_sha512       = "8206065d61f47ed75eac3d67ab9d740b0be5f21b4bc86af183045a9dc745011d54e9476742545d3604840b6a32c776618f1a0c10dc450653c5d2544eab4cd273" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "teste-arquivo-2-outro_arquivo.txt" -> null
      - id                   = "90275ddbbecce2aea76a40a6a400f5f0055f23d2" -> null
    }

  # module.pets[2].random_pet.pet01 will be destroyed
  # (because module.pets[2] is not in configuration)
  - resource "random_pet" "pet01" {
      - id        = "engaged-emu" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets[2].random_pet.pet02 will be destroyed
  # (because module.pets[2] is not in configuration)
  - resource "random_pet" "pet02" {
      - id        = "humane-filly" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets[3].local_file.arquivo will be destroyed
  # (because module.pets[3] is not in configuration)
  - resource "local_file" "arquivo" {
      - content              = "exotic-lark" -> null
      - content_base64sha256 = "WfYdTAyAncNKJlP4v2LLTjkk+Cw4EjHlhMEF+fv/oBM=" -> null
      - content_base64sha512 = "wgKBu4yRIjwpkHaul+5uRvGmq54qkAOLhUPUPWrCInDWA2P2GqVYvRL/Q/wljBQKhdKhQDm7V/MND4ttddBeQw==" -> null
      - content_md5          = "8c360f3291e8eec7a061aef30f8dd4fa" -> null
      - content_sha1         = "10032508bfbd9260b942b9c74021119d56e4839f" -> null
      - content_sha256       = "59f61d4c0c809dc34a2653f8bf62cb4e3924f82c381231e584c105f9fbffa013" -> null
      - content_sha512       = "c20281bb8c91223c299076ae97ee6e46f1a6ab9e2a90038b8543d43d6ac22270d60363f61aa558bd12ff43fc258c140a85d2a14039bb57f30d0f8b6d75d05e43" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "teste-arquivo-3-arquivo.txt" -> null
      - id                   = "10032508bfbd9260b942b9c74021119d56e4839f" -> null
    }

  # module.pets[3].local_file.outro_arquivo will be destroyed
  # (because module.pets[3] is not in configuration)
  - resource "local_file" "outro_arquivo" {
      - content              = "quality-colt" -> null
      - content_base64sha256 = "oReAP3slPPwYHjGPGoaVGDuWDh+lGEOv3B6y93KnNKw=" -> null
      - content_base64sha512 = "UTWtIgjcHJA7GVVLsAyt/zb8TlDH4IrItqzd8Fb7tgAYUfjH8GvTCuufhL8YTItEkz9A2M52Bbo8VjxLlZFNbg==" -> null
      - content_md5          = "8f4601862781add0b39110a515225f96" -> null
      - content_sha1         = "bec6e266786a5af65846af76737bcdb208078028" -> null
      - content_sha256       = "a117803f7b253cfc181e318f1a8695183b960e1fa51843afdc1eb2f772a734ac" -> null
      - content_sha512       = "5135ad2208dc1c903b19554bb00cadff36fc4e50c7e08ac8b6acddf056fbb6001851f8c7f06bd30aeb9f84bf184c8b44933f40d8ce7605ba3c563c4b95914d6e" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "teste-arquivo-3-outro_arquivo.txt" -> null
      - id                   = "bec6e266786a5af65846af76737bcdb208078028" -> null
    }

  # module.pets[3].random_pet.pet01 will be destroyed
  # (because module.pets[3] is not in configuration)
  - resource "random_pet" "pet01" {
      - id        = "exotic-lark" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets[3].random_pet.pet02 will be destroyed
  # (because module.pets[3] is not in configuration)
  - resource "random_pet" "pet02" {
      - id        = "quality-colt" -> null
      - length    = 2 -> null
      - separator = "-" -> null
    }

  # module.pets["pre01"].local_file.arquivo will be created
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
      + filename             = "teste-arquivo-pre01-arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets["pre01"].local_file.outro_arquivo will be created
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
      + filename             = "teste-arquivo-pre01-outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets["pre01"].random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets["pre01"].random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets["pre02"].local_file.arquivo will be created
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
      + filename             = "teste-arquivo-pre02-arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets["pre02"].local_file.outro_arquivo will be created
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
      + filename             = "teste-arquivo-pre02-outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets["pre02"].random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets["pre02"].random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets["pre03"].local_file.arquivo will be created
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
      + filename             = "teste-arquivo-pre03-arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets["pre03"].local_file.outro_arquivo will be created
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
      + filename             = "teste-arquivo-pre03-outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets["pre03"].random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets["pre03"].random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets["pre04"].local_file.arquivo will be created
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
      + filename             = "teste-arquivo-pre04-arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets["pre04"].local_file.outro_arquivo will be created
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
      + filename             = "teste-arquivo-pre04-outro_arquivo.txt"
      + id                   = (known after apply)
    }

  # module.pets["pre04"].random_pet.pet01 will be created
  + resource "random_pet" "pet01" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

  # module.pets["pre04"].random_pet.pet02 will be created
  + resource "random_pet" "pet02" {
      + id        = (known after apply)
      + length    = 2
      + separator = "-"
    }

Plan: 16 to add, 0 to change, 16 to destroy.

Changes to Outputs:
  ~ nome_pet01 = [
      - "fluent-crow",
      - "cheerful-airedale",
      - "engaged-emu",
      - "exotic-lark",
      + {
          + pre01 = {
              + nome_01 = (known after apply)
              + nome_02 = (known after apply)
            }
          + pre02 = {
              + nome_01 = (known after apply)
              + nome_02 = (known after apply)
            }
          + pre03 = {
              + nome_01 = (known after apply)
              + nome_02 = (known after apply)
            }
          + pre04 = {
              + nome_01 = (known after apply)
              + nome_02 = (known after apply)
            }
        },
    ]
  ~ nome_pet02 = [
      - "suited-magpie",
      - "key-glowworm",
      - "humane-filly",
      - "quality-colt",
      + {
          + pre01 = {
              + nome_01 = (known after apply)
              + nome_02 = (known after apply)
            }
          + pre02 = {
              + nome_01 = (known after apply)
              + nome_02 = (known after apply)
            }
          + pre03 = {
              + nome_01 = (known after apply)
              + nome_02 = (known after apply)
            }
          + pre04 = {
              + nome_01 = (known after apply)
              + nome_02 = (known after apply)
            }
        },
    ]
module.pets[0].local_file.arquivo: Destroying... [id=7bbfddfdd58c0b8933b4035e720f9102fbfb7c6c]
module.pets[2].local_file.arquivo: Destroying... [id=dbf1350c5f63273ea7d6f5f7e190412a33b79536]
module.pets[0].local_file.outro_arquivo: Destroying... [id=7baad0cbf3c7571dc70bfc46a48fa5d13b39adbd]
module.pets[3].local_file.outro_arquivo: Destroying... [id=bec6e266786a5af65846af76737bcdb208078028]
module.pets[2].local_file.outro_arquivo: Destroying... [id=90275ddbbecce2aea76a40a6a400f5f0055f23d2]
module.pets[3].local_file.arquivo: Destroying... [id=10032508bfbd9260b942b9c74021119d56e4839f]
module.pets[1].local_file.arquivo: Destroying... [id=65bf2acbeb6f31e3c342e942596ad09689b5bf70]
module.pets[3].local_file.outro_arquivo: Destruction complete after 0s
module.pets[0].local_file.arquivo: Destruction complete after 0s
module.pets[2].local_file.outro_arquivo: Destruction complete after 0s
module.pets[1].local_file.outro_arquivo: Destroying... [id=e3de02328e9be0b15ed3502fd52e5400c561f096]
module.pets["pre02"].random_pet.pet01: Creating...
module.pets["pre01"].random_pet.pet02: Creating...
module.pets[0].local_file.outro_arquivo: Destruction complete after 0s
module.pets["pre01"].random_pet.pet02: Creation complete after 0s [id=liberal-kit]
module.pets[3].local_file.arquivo: Destruction complete after 0s
module.pets[1].local_file.arquivo: Destruction complete after 0s
module.pets[2].local_file.arquivo: Destruction complete after 0s
module.pets[1].local_file.outro_arquivo: Destruction complete after 0s
module.pets["pre03"].random_pet.pet02: Creating...
module.pets["pre02"].random_pet.pet02: Creating...
module.pets["pre02"].random_pet.pet01: Creation complete after 0s [id=accurate-llama]
module.pets["pre02"].random_pet.pet02: Creation complete after 0s [id=natural-lark]
module.pets["pre01"].random_pet.pet01: Creating...
module.pets["pre03"].random_pet.pet02: Creation complete after 0s [id=dear-koala]
module.pets["pre04"].random_pet.pet01: Creating...
module.pets["pre03"].random_pet.pet01: Creating...
module.pets[3].random_pet.pet02: Destroying... [id=quality-colt]
module.pets[0].random_pet.pet01: Destroying... [id=fluent-crow]
module.pets[1].random_pet.pet02: Destroying... [id=key-glowworm]
module.pets[3].random_pet.pet01: Destroying... [id=exotic-lark]
module.pets[3].random_pet.pet02: Destruction complete after 0s
module.pets[2].random_pet.pet02: Destroying... [id=humane-filly]
module.pets[0].random_pet.pet02: Destroying... [id=suited-magpie]
module.pets["pre04"].random_pet.pet01: Creation complete after 0s [id=guided-raccoon]
module.pets[0].random_pet.pet01: Destruction complete after 0s
module.pets["pre01"].random_pet.pet01: Creation complete after 0s [id=trusted-bream]
module.pets[3].random_pet.pet01: Destruction complete after 0s
module.pets[1].random_pet.pet01: Destroying... [id=cheerful-airedale]
module.pets[2].random_pet.pet01: Destroying... [id=engaged-emu]
module.pets["pre04"].random_pet.pet02: Creating...
module.pets[2].random_pet.pet02: Destruction complete after 0s
module.pets[0].random_pet.pet02: Destruction complete after 0s
module.pets[1].random_pet.pet02: Destruction complete after 0s
module.pets["pre03"].random_pet.pet01: Creation complete after 0s [id=excited-lobster]
module.pets[2].random_pet.pet01: Destruction complete after 0s
module.pets[1].random_pet.pet01: Destruction complete after 0s
module.pets["pre04"].random_pet.pet02: Creation complete after 0s [id=probable-bee]
module.pets["pre02"].local_file.arquivo: Creating...
module.pets["pre01"].local_file.outro_arquivo: Creating...
module.pets["pre02"].local_file.outro_arquivo: Creating...
module.pets["pre01"].local_file.outro_arquivo: Creation complete after 0s [id=be30e00565101410aed0453deca03f74e52446a3]
module.pets["pre02"].local_file.outro_arquivo: Creation complete after 0s [id=267733df3ffe24a548b6f8f5eb3ec7e42db7657c]
module.pets["pre03"].local_file.outro_arquivo: Creating...
module.pets["pre02"].local_file.arquivo: Creation complete after 0s [id=279a636f5eeb5e9880e33d1a26b24da1bde05938]
module.pets["pre03"].local_file.arquivo: Creating...
module.pets["pre03"].local_file.outro_arquivo: Creation complete after 0s [id=adac50d75645ed2f6c6d48f95fe7705622cc9c3a]
module.pets["pre03"].local_file.arquivo: Creation complete after 0s [id=77d0f390dc05da3a3087a3a1f175e98d4a13f01b]
module.pets["pre04"].local_file.outro_arquivo: Creating...
module.pets["pre04"].local_file.arquivo: Creating...
module.pets["pre01"].local_file.arquivo: Creating...
module.pets["pre04"].local_file.arquivo: Creation complete after 0s [id=b23a8b913918b10e5143cd16df4b33b00e5faf45]
module.pets["pre04"].local_file.outro_arquivo: Creation complete after 0s [id=8c68bf75308b484627220ccbde4f5545b418331c]
module.pets["pre01"].local_file.arquivo: Creation complete after 0s [id=53ac5896f5ce5ffac84420cc33ccd164c69e5643]

Apply complete! Resources: 16 added, 0 changed, 16 destroyed.

Outputs:

nome_pet01 = [
  {
    "pre01" = {
      "nome_01" = "trusted-bream"
      "nome_02" = "liberal-kit"
    }
    "pre02" = {
      "nome_01" = "accurate-llama"
      "nome_02" = "natural-lark"
    }
    "pre03" = {
      "nome_01" = "excited-lobster"
      "nome_02" = "dear-koala"
    }
    "pre04" = {
      "nome_01" = "guided-raccoon"
      "nome_02" = "probable-bee"
    }
  },
]
nome_pet02 = [
  {
    "pre01" = {
      "nome_01" = "trusted-bream"
      "nome_02" = "liberal-kit"
    }
    "pre02" = {
      "nome_01" = "accurate-llama"
      "nome_02" = "natural-lark"
    }
    "pre03" = {
      "nome_01" = "excited-lobster"
      "nome_02" = "dear-koala"
    }
    "pre04" = {
      "nome_01" = "guided-raccoon"
      "nome_02" = "probable-bee"
    }
  },
]
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/terraform-modules/002-materiais$

~~~~