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
