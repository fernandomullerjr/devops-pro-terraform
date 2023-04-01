

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
git reset -- terraform-modules/005-materiais/.terraform
git reset -- terraform-modules/005-materiais/.terraform/*
git reset -- terraform-modules/005-materiais/terraform.tfstate
git reset -- terraform-modules/005-materiais/terraform.tfstate.backup
git commit -m "Terraform Modules - 005 Criando um módulo na prática."
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

#