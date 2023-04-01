module "pets" {
  source          = "./modules/pets"
  prefixo_arquivo = "teste-arquivo-${each.key}"
  for_each = toset( ["pre01", "pre02", "pre03", "pre04"] )
}
