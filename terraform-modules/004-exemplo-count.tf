
# Módulo usando count
module "pets" {
  source          = "./modules/pets"
  prefixo_arquivo = "teste-arquivo-${count.index}"
  count = 4
}


# OUTPUTS
output "nome_pet01" {
  value = module.pets[*].nome_01
}

output "nome_pet02" {
  value = module.pets[*].nome_02
}
