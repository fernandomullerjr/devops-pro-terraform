
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








## PENDENTE
- Subir droplet via TF
<https://www.qunsul.com/posts/creating-a-digital-ocean-instance-using-terraform.html>
- Stop no Droplet.
- Acompanhar billing.