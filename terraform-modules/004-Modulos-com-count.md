

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