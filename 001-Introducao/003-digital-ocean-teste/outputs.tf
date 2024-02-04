output "droplet_info" {
  value = digitalocean_droplet.web
}

output "droplet_id" {
  value       = digitalocean_droplet.web.id
  description = "The ID of the Droplet"
}

output "droplet_urn" {
  value       = digitalocean_droplet.web.urn
  description = "The uniform resource name of the Droplet"
}

output "droplet_name" {
  value       = digitalocean_droplet.web.name
  description = "The name of the Droplet"
}

output "droplet_region" {
  value       = digitalocean_droplet.web.region
  description = "The region of the Droplet"
}

output "droplet_image" {
  value       = digitalocean_droplet.web.image
  description = "The image of the Droplet"
}

output "droplet_ipv6" {
  value       = digitalocean_droplet.web.ipv6
  description = "Is IPv6 enabled"
}

output "droplet_ipv6_address" {
  value       = digitalocean_droplet.web.ipv6_address
  description = "The IPv6 address"
}

output "droplet_ipv4_address" {
  value       = digitalocean_droplet.web.ipv4_address
  description = "The IPv4 address"
}

output "droplet_ipv4_address_private" {
  value       = digitalocean_droplet.web.ipv4_address_private
  description = "The private networking IPv4 address"
}

output "droplet_locked" {
  value       = digitalocean_droplet.web.locked
  description = "Is the Droplet locked"
}

output "droplet_private_networking" {
  value       = digitalocean_droplet.web.private_networking
  description = "Is private networking enabled"
}

output "droplet_price_hourly" {
  value       = digitalocean_droplet.web.price_hourly
  description = "Droplet hourly price"
}

output "droplet_price_monthly" {
  value       = digitalocean_droplet.web.price_monthly
  description = "Droplet monthly price"
}

output "droplet_size" {
  value       = digitalocean_droplet.web.size
  description = "The instance size"
}

output "droplet_disk" {
  value       = digitalocean_droplet.web.disk
  description = "The size of the instance's disk in GB"
}

output "droplet_vcpus" {
  value       = digitalocean_droplet.web.vcpus
  description = "The number of the instance's virtual CPUs"
}

output "droplet_status" {
  value       = digitalocean_droplet.web.status
  description = "The status of the Droplet"
}

output "droplet_tags" {
  value       = digitalocean_droplet.web.tags
  description = "The tags associated with the Droplet"
}

output "droplet_volume_ids" {
  value       = digitalocean_droplet.web.volume_ids
  description = "A list of the attached block storage volumes"
}
