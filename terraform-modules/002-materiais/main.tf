module "pets" {
  source          = "./modules/pets"
  prefixo_arquivo = "teste-arquivo-${count.index}"
  count = 4
}
