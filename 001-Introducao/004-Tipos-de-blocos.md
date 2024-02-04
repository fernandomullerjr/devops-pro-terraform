
# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "001 Introdução - 004 Tipos de Blocos."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ############################################################################
# ############################################################################
# ############################################################################
# Tipos de Blocos


- Subir Droplet via curl:

~~~~bash
curl -X POST -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$TOKEN'' \
    -d '{"name":"ubuntu-s-1vcpu-1gb-sfo3-01",
        "size":"s-1vcpu-1gb",
        "region":"sfo3",
        "image":"ubuntu-23-10-x64",
        "monitoring":true,
        "tags":["ambiente:teste"]}' \
    "https://api.digitalocean.com/v2/droplets"
~~~~


## DigitalOcean Provider

<https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs>

Example Usage

~~~~tf
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a web server
resource "digitalocean_droplet" "web" {
  # ...
}
~~~~





## digitalocean_droplet

<https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet>

Provides a DigitalOcean Droplet resource. This can be used to create, modify, and delete Droplets. Droplets also support provisioning.
Example Usage

~~~~tf
# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "web" {
  image  = "ubuntu-20-04-x64"
  name   = "web-1"
  region = "nyc2"
  size   = "s-1vcpu-1gb"
}
~~~~






Droplet has been destroyed.




Plan: 1 to add, 0 to change, 0 to destroy.
digitalocean_droplet.web: Creating...
╷
│ Error: Error creating droplet: POST https://api.digitalocean.com/v2/droplets: 422 (request "ea965b9d-bdaa-4aee-87b0-d020f4642cf6") nyc2 is unavailable.
│
│   with digitalocean_droplet.web,
│   on droplet.tf line 3, in resource "digitalocean_droplet" "web":
│    3: resource "digitalocean_droplet" "web" {
│
╵



- Alterando region para "sfo3".
- Novo apply:

terraform apply -var-file=.terraform.tfvars

Plan: 1 to add, 0 to change, 0 to destroy.
digitalocean_droplet.web: Creating...


- Criado:

~~~~bash

Terraform will perform the following actions:

  # digitalocean_droplet.web will be created
  + resource "digitalocean_droplet" "web" {
      + backups              = false
      + created_at           = (known after apply)
      + disk                 = (known after apply)
      + graceful_shutdown    = false
      + id                   = (known after apply)
      + image                = "ubuntu-20-04-x64"
      + ipv4_address         = (known after apply)
      + ipv4_address_private = (known after apply)
      + ipv6                 = false
      + ipv6_address         = (known after apply)
      + locked               = (known after apply)
      + memory               = (known after apply)
      + monitoring           = false
      + name                 = "web-1"
      + price_hourly         = (known after apply)
      + price_monthly        = (known after apply)
      + private_networking   = (known after apply)
      + region               = "sfo3"
      + resize_disk          = true
      + size                 = "s-1vcpu-1gb"
      + status               = (known after apply)
      + urn                  = (known after apply)
      + vcpus                = (known after apply)
      + volume_ids           = (known after apply)
      + vpc_uuid             = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
digitalocean_droplet.web: Creating...
digitalocean_droplet.web: Still creating... [10s elapsed]
digitalocean_droplet.web: Still creating... [20s elapsed]
digitalocean_droplet.web: Still creating... [30s elapsed]
digitalocean_droplet.web: Still creating... [40s elapsed]
digitalocean_droplet.web: Creation complete after 42s [id=399278372]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/001-Introducao/003-digital-ocean-teste$

~~~~





- Destruindo:

~~~~bash

fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/001-Introducao/003-digital-ocean-teste$ terraform destroy -var-file=.terraform.tfvars
digitalocean_droplet.web: Refreshing state... [id=399278683]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # digitalocean_droplet.web will be destroyed
  - resource "digitalocean_droplet" "web" {
      - backups              = false -> null
      - created_at           = "2024-02-04T00:02:46Z" -> null
      - disk                 = 25 -> null
      - graceful_shutdown    = false -> null
      - id                   = "399278683" -> null
      - image                = "ubuntu-20-04-x64" -> null
      - ipv4_address         = "137.184.122.115" -> null
      - ipv4_address_private = "10.124.0.2" -> null
      - ipv6                 = false -> null
      - locked               = false -> null
      - memory               = 1024 -> null
      - monitoring           = false -> null
      - name                 = "web-1" -> null
      - price_hourly         = 0.00893 -> null
      - price_monthly        = 6 -> null
      - private_networking   = true -> null
      - region               = "sfo3" -> null
      - resize_disk          = true -> null
      - size                 = "s-1vcpu-1gb" -> null
      - status               = "active" -> null
      - tags                 = [] -> null
      - urn                  = "do:droplet:399278683" -> null
      - vcpus                = 1 -> null
      - volume_ids           = [] -> null
      - vpc_uuid             = "80ae0939-1db9-4cb1-a692-0caf26bd089f" -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

digitalocean_droplet.web: Destroying... [id=399278683]
digitalocean_droplet.web: Still destroying... [id=399278683, 10s elapsed]
digitalocean_droplet.web: Still destroying... [id=399278683, 20s elapsed]
digitalocean_droplet.web: Destruction complete after 22s

Destroy complete! Resources: 1 destroyed.
fernando@debian10x64:~/cursos/terraform/devops-pro-terraform/001-Introducao/003-digital-ocean-teste$

~~~~






## PENDENTE
- Subir droplet via TF
<https://www.qunsul.com/posts/creating-a-digital-ocean-instance-using-terraform.html>
terraform apply -var-file=.terraform.tfvars
- Stop no Droplet.
- Acompanhar billing.